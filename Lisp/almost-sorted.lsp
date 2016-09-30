;; Bennett Alex Myers - CS 3210 - Fall 2016
;; =============================================================================
;; Almost sorted: given a list of numbers, return true or nil based on if the 
;; list is almost sorted. An almost sorted list is one in which the number of
;; inversions is greater than 0 and lesser than 0.2n, where n is the number of
;; elements in the list. An inversion is a pair of adjacent values in the wrong
;; order.
;; Parameters:
;;   lst - a list of numbers
;; Assumptions:
;;   1. lst contains no duplicates
;;   2. lst is not nested

;; Main function

(defun is-almost-sorted (lst)
  (cond ((=  (count-inversions lst)                  0) nil)
        ((>= (count-inversions lst) (/ (length lst) 5)) nil)
        (t                                              t)
  )
)

(defun count-inversions (lst)
  (cond ((eq lst nil)                                                0)
        ((eq (length lst) 1)                                         0)
        ((> (car lst) (car (cdr lst))) (+ 1 (count-inversions (cdr lst))))
        (t                                  (count-inversions (cdr lst)))
  )
)

;; test plan for is-almost-sorted:  
;; test case                          data                       expected result      
;; -----------------------------------------------------------------------------
;; empty list                         ()                         nil
;; singleton list                     ()                         nil
;; sorted list of length <= 5         (1 2 3)                    nil
;; length <= 5 with one inversion     (1 3 2)                    nil
;; length <= 5 with two inversions    (3 2 1)                    nil
;; sorted list of length > 5          (1 2 3 4 5 6)              nil
;; length > 5 with one inversion      (1 2 3 4 6 5)              t
;; length > 5 with two inversions     (1 3 2 4 6 5)              nil
;; length > 10 with two inversions    (1 3 2 4 6 5 7 8 9 10 11)  t
;; length > 10 with three inversions  (1 3 2 4 6 5 7 9 8 10 11)  nil
;;
;; test plan for count-inversions:
;; test case                          data                       expected result
;; -----------------------------------------------------------------------------
;; empty list                         ()                         0
;; singleton list                     (1)                        0
;; sorted list                        (1 2 3 4 5)                0
;; one inversion                      (1 2 4 3 5)                1
;; two inversions                     (2 1 3 5 4)                2
;; reversed list                      (5 4 3 2 1)                4