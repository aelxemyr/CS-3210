;; Bennett Alex Myers - CS 3210 - Fall 2016
;; ===========================================================================
;; Clumps: given a list, count the number of clumps.
;; Parameters:
;;   lst - a list of atoms
;; Assumptions:
;;   No nested lists

;; Main function
(defun count-clumps (lst)
  (cond ((eq lst nil)
          0
        )
        ((starts-with-clump lst)
          (+ 1 (count-clumps (get-list-after-clump (cdr lst))))
        )
        (t
          (count-clumps (cdr lst))
        )
  )
)

(defun starts-with-clump (lst)
  (eq (car lst) (car (cdr lst)))
)

(defun get-list-after-clump (lst)
  (cond ((eq (cdr lst) nil)      nil)
        ((starts-with-clump lst) (get-list-after-clump (cdr lst)))
        (t                       (cdr lst))
  )
)

;; test plan for count-clumps: 
;; test case                            data                   expected result
;; ---------------------------------------------------------------------------
;; empty list                           ()                     0
;; singleton list                       (data)                 0
;; no clumps                            (a b c d e)            0
;; no clumps with duplicates            (a b a b c)            0       
;; one clump (size two)                 (a a b c d)            1
;; whole list clump                     (a a a a a)            1
;; mixed clump list                     (a a b c c c d d)      3
