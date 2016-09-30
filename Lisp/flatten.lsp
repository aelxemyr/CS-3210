;; Bennett Alex Myers - CS 3210 - Fall 2016
;; ===========================================================================
;; Flatten: given a list of arbitrary depth, remove nesting. This preserves 
;; the elements and their order; note that flattening an embedded nil removes
;; it.
;; Parameters:
;;   lst - a list

;; Main function
(defun flatten (lst)
  (cond ((eq lst nil)      nil)
        ((listp (car lst)) (append (flatten (car lst)) (flatten (cdr lst))))
        (t                 (cons (car lst) (flatten (cdr lst))))
  )
)

;; test plan for flatten:  
;; test case                     data                          expected result 
;; ---------------------------------------------------------------------------
;; empty list                    ()                            ()
;; singleton list                (a)                           (a)
;; no nesting                    (a b c)                       (a b c)
;; nested empty list             (())                          ()
;; nested singleton              ((a))                         (a)
;; arbitrary nesting             (a (b c ()) () (d ((e)))      (a b c d e)
