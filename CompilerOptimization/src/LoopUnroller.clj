(require '[clojure.java.io :as io])
(require '[clojure.string :as str])

;; Read file and return as sequence of lines (strings)
(defn read-code [filename]
  (with-open [rdr (io/reader filename)]
    (doall (line-seq rdr))))

;; Write a line to an existing file
(defn write-line [line filename]
  (with-open [wrtr (io/writer filename :append true)]
    (.write wrtr line)))

;; Determine to which part of a loop a line corresponds
(defn get-line-token [line]
  (cond
    (str/starts-with? line "**") :loop-description
    (str/starts-with? line "for") :loop-header
    (str/starts-with? line "}") :loop-end
    true :loop-body))

;; Predicate which determines if line is loop code
(defn loop-code? [line]
  (not= :loop-description (get-line-token line)))

;; Transform a list of lines into a list of loops
;; That is, given a list of lines which contain the code for n loops,
;; return a list of n loops, where each loop is itself a list of lines
;; corresponding to a single loop.
(defn get-loop-list [lines]
  (if (empty? lines) ()
      (cons
        (cons (first lines) (take-while loop-code? (rest lines)))
        (get-loop-list (drop-while loop-code? (rest lines))))))

;; Return the name of the counter variable from a loop header
(defn get-counter-variable-name [loop-header]
  (.substring loop-header (+ (.indexOf loop-header "(") 1)
                          (.indexOf loop-header "=")))

;; Return the initial value of the counter variable from a loop header
(defn get-initial-counter-value [loop-header]
  (.substring loop-header (+ (.indexOf loop-header "=") 1)
                          (.indexOf loop-header ";")))

;; Return the loop termination condition from a loop header
(defn get-termination-condition [loop-header]
  (.substring loop-header (.indexOf loop-header "<")
                          (.lastIndexOf loop-header ";")))

;; Return the comparison function from the loop termination condition
;; of a loop header; i.e., return either "<" or "<="
(defn get-termination-comparison [loop-header]
  (if (str/starts-with? (get-termination-condition loop-header) "<=") "<=" "<"))

;; Return the upper bound from the loop termination condition of a loop
;; header
(defn get-termination-upper-bound [loop-header]
  (if (= (get-termination-comparison loop-header) "<=")
    (.substring (get-termination-condition loop-header) 2)
    (.substring (get-termination-condition loop-header) 1)))

;; Remove whitespace from string
(defn remove-whitespace [string]
  (str/replace string " " ""))

;; Get the loop header from a loop and remove whitespace
(defn loop-header [loop]
  (remove-whitespace (second loop)))

;; Return the body of the loop as a list of statements (strings)
(defn get-loop-body [loop]
  (take-while (fn [line] (= :loop-body (get-line-token line))) (drop 2 loop)))

;; Parse loop code and return a map of the loop's description text, initial
;; counter value, termination condition, and list of body statements
(defn parse [loop]
  {:description (first loop)
   :counter-name (get-counter-variable-name (loop-header loop))
   :initial-counter (get-initial-counter-value (loop-header loop))
   :termination-comparison (get-termination-comparison (loop-header loop))
   :termination-upper-bound (get-termination-upper-bound (loop-header loop))
   :body (map str/trim (get-loop-body loop))})

;; Inner function for unrolling a parsed loop
(defn unroll-inner [loop-map counter]
  (if (or
        (and (= (loop-map :termination-comparison) "<=")
             (= (.toString (- counter 1)) (loop-map :termination-upper-bound)))
        (and (= (loop-map :termination-comparison) "<")
             (= (.toString counter) (loop-map :termination-upper-bound))))
    ()
    (list (loop-map :body)
      (.concat (loop-map :counter-name) "++;")
      (unroll-inner loop-map (+ counter 1)))))

;; Outer function for unrolling a parsed loop
(defn unroll [loop-map]
  (flatten
    (list (loop-map :description)
      (.concat (.concat (loop-map :counter-name) " = ") (loop-map :initial-counter))
      (unroll-inner loop-map (read-string (loop-map :initial-counter))))))

;; Read loops from file and writes unrolled loops to file with description
(defn loop-unroller [inputfilename outputfilename]
  (write-line
    (str/join "\n"
      (flatten (map unroll (map parse (get-loop-list (read-code inputfilename))))))
    outputfilename))

;; Main function
(loop-unroller "Loops" "UnrolledLoops")