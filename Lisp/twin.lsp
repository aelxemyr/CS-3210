;; Bennett Alex Myers - CS 3210 - Fall 2016
;; =============================================================================
;; Twin: given a list, duplicate each element of the list.
;; Parameters:
;;   lst - a list
;; Assumptions:
;;   1. lst is not nested
;;
;; Untwin: given a list, removes pairs, where pairs are defined as adjacent
;; equal values.
;; Parameters:
;;   lst - a list
;; Assumptions:
;;   1. lst is not nested
;;   2. no more than two identical elements will be adjacent

;; twin
(defun twin (lst)
  (cond ((eq lst nil) nil)
        (t            (cons (car lst) (cons (car lst) (twin (cdr lst)))))
  )
)

;;untwin
(defun untwin (lst)
  (cond ((eq lst nil)
          nil
        )
        ((eq (car lst) (car (cdr lst))) 
          (cons (car lst) (untwin (cdr (cdr lst))))
        )
        (t
          (cons (car lst) (untwin (cdr lst)))
        )
  )
) 

;; test plan for twin:  
;; test case                          data             expected result      
;; -----------------------------------------------------------------------------
;; empty list                         ()               ()
;; singleton list                     (a)              (a a)
;; no duplicates                      (1 a xyz)        (1 1 a a xyz xyz)
;; duplicates: one elements           (a a a)          (a a a a a a)
;; duplicates: multiple elements      (a a 1)          (a a a a 1 1)
;;
;; test plan for untwin:
;; test case                          data             expected result
;; -----------------------------------------------------------------------------
;; empty list                         ()               ()
;; singleton list                     (a)              (a)
;; list with no pairs                 (a b c)          (a b c)
;; list with one pair                 (a b b c)        (a b c)
;; list with non pair duplicates      (a b a)          (a b a)
;; list with pairs and non pairs      (a a b a)        (a b a)
