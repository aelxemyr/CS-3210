;; Bennett Alex Myers - CS 3210 - Fall 2016
;; =============================================================================
;; Fizz Buzz function: outputs integers from one to twenty with the following 
;; additions:
;;   1. if the number is divisible by three, output a sublist containing the 
;;      number and the word fizz;
;;   2. if the number is divisible by five, output a sublist containing the 
;;      number and the word buzz;
;;   3. and if the number is divisible by both three and five, output a 
;;      sublist containing the number and the words fizz and buzz.

;; Main fizzbuzz function
(defun fizzbuzz ()
  (fizzbuzz-inner '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
)

;; Fizzbuzz helper function - adds fizz, buzz, fizz buzz, or nothing according 
;; to the rules of fizzbuzz.
(defun add-fizz-or-buzz (n)
  (cond ((= 0 (mod n 15)) (cons n '(fizz buzz)))
        ((= 0 (mod n 3 )) (cons n '(fizz)))
        ((= 0 (mod n 5))  (cons n '(buzz)))
        ( t                n)
  )
)

;; Fizzbuzz helper function - constructs output list for fizzbuzz.
(defun fizzbuzz-inner (lst)
  (cond ((eq lst nil) nil)
        (t (cons (add-fizz-or-buzz (car lst)) (fizzbuzz-inner (cdr lst))))
  )
)

;; test plan for fizzbuzz:  
;; main function simply requires a check that output matches expected result as
;; specified on spec sheet.
;;
;; helper function test plans:
;;
;; test plan for add-fizz-or-buzz:  
;; test case                          data           expected result      
;; ---------------------------------------------------------------------------
;; Not divisible by 3 or 5            1              1            
;; Divisible by 3                     3              (3 fizz)           
;; Divisible by 5                     5              (5 buzz)      
;; Divisible by 3 and 5               15             (15 fizz buzz)      
;;
;; test plan for fizz-buzz-inner:
;; testing largely to ensure list construction mechanism is correct.
;; test case                          data           expected result      
;; ---------------------------------------------------------------------------
;; Empty List                         ()             ()      
;; Singleton List                     (1)            (1)      
;; Singleton with divisibility        (15)           ((15 fizz buzz))      
;; Everything                         (1 3 5 15)     (1 (3 fizz) (5 buzz) 
;;                                                    (15 fizz buzz))           

