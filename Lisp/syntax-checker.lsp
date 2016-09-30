;; Bennett Alex Myers - CS 3210 - Fall 2016
;; ===========================================================================
;; Expression syntax checker: given a possibly nested list of expressions with
;; numeric operands and binary infix operators plus, minus, times, and
;; divideby, check if the following errors are present: wrong number of tokens
;; (i.e., not three), operands not numeric, or invalid operator. If an error 
;; is present, return nil; otherwise, return true.
;; Parameters:
;;   expr - a list representing an expression

;; Main function
(defun check-expr (expr)
  (and (check-tokens   expr)
       (check-operands expr)
       (check-operator expr)
  )
)

;; Check number of tokens: exactly three
(defun check-tokens (expr)
  (= 3 (length expr))
)

;; Check operands: must be numeric or valid expressions
;; Precondition: expr has length three
(defun check-operands (expr)
  (and (or (numberp (car expr))
           (and (listp (car expr)) (check-expr (car expr)))
       )
       (or (numberp (get-third expr))
           (and (listp (get-third expr)) (check-expr (get-third expr)))
       )
  )
)

;; Return the third element of the list
;; Precondition: lst has at least three elements
(defun get-third (lst)
  (car (cdr (cdr lst)))
)

;; Check operator: must be one of the following: plus, minus, times, divideby
;; Precondition: expr has length at least two
(defun check-operator (expr)
  (or (eq (car (cdr expr)) 'plus)
      (eq (car (cdr expr)) 'minus)
      (eq (car (cdr expr)) 'times)
      (eq (car (cdr expr)) 'divideby)
  )
)

;; test plan for check-expr:
;; test case                     data                          expected result
;; ---------------------------------------------------------------------------
;; empty list                    ()                            nil
;; unnested, valid               (2 times 5)                   t
;; nested, valid                 (4 plus (2 times 5))          t
;; unnested, invalid             (a times 5)                   nil
;; nested, invalid               (2 minus (3 divideby z))      nil
;;
;; test plan for check-tokens:
;; test case                     data                         expected result 
;; ---------------------------------------------------------------------------
;; empty list                    ()                           nil
;; singleton list                (a)                          nil
;; two element list              (a b)                        nil
;; three element list            (a b c)                      t
;; four element list             (a b c d)                    nil
;;
;; test plan for check-operands (assumption: correct number of tokens):
;; test case                     data                         expected result 
;; ---------------------------------------------------------------------------
;; numeric operands              (2 x 3)                      t
;; left numeric operand          (2 x a)                      nil
;; right numeric operand         (a x 3)                      nil
;; non-numeric operands          (a x b)                      nil
;;
;; test plan for check-operator (assumption: numeric operands):
;; test case                     data                        expected result  
;; ---------------------------------------------------------------------------
;; valid operator: plus          (2 plus 3)                  t
;; valid operator: minus         (2 minus 3)                 t
;; valid operator: times         (2 times 3)                 t
;; valid operator: divideby      (2 divideby 3)              t
;; invalid operator              (2 x 3)                     t