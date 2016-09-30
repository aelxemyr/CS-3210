;; Bennett Alex Myers - CS 3210 - Fall 2016
;; =============================================================================
;; Enforce upper limit: given a number and a list which may be nested, produce a
;; new list in which all values originally above the number are replaced by that
;; number.
;; Parameters:
;;   lim - number to be used as upper limit
;;   lst - a list
;; Assumptions:
;;   1. lim is a number

;; Main function
(defun enforce-limit (lim lst)
  (cond ((eq lst nil)
          nil
        )
        ((listp (car lst))
          (cons (enforce-limit lim (car lst)) (enforce-limit lim (cdr lst)))
        )
        ((numberp (car lst))
          (cons (apply-limit lim (car lst)) (enforce-limit lim (cdr lst)))
        )
        (t
          (cons (car lst) (enforce-limit lim (cdr lst)))
        )
  )
)

(defun apply-limit (lim n)
  (cond ((> n lim) lim)
        (t           n)
  )
)

;; test plan for enforce-limit:
;; test case                      data                     expected result      
;; -----------------------------------------------------------------------------
;; empty list                     1, ()                    ()
;; singleton lesser than limit    2, (1)                   (1)
;; singleton greater than limit   1, (2)                   (1)
;; nested singleton below limit   2, ((1))                 ((1))
;; nested singleton above limit   1, ((2))                 ((1))
;; list of numbers                3, (1 2 3 4 5)           (1 2 3 3 3)
;; nested list of numbers         3, (1 (2 3) ((4) 5))     (1 (2 3) ((3) 3)
;; list of arbitrary elements     3, (1 x (5 y) z () 20)   (1 x (3 y) z () 3)
