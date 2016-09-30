;; Bennett Alex Myers - CS 3210 - Fall 2016
;; =============================================================================
;; Sort by recency: given a word and a list of words, rearranges the list based
;; on recency. If the word is not in the list, the word is added at the front of
;; the list. If the word is in the list, its position is changed to be first in
;; the list.
;; Parameters:
;;   word - a string consisting only of letters
;;   lst - a list of words
;; Assumptions:
;;   1. lst contains no duplicates
;;   2. lst is not nested 

;; Main function

(defun sort-by-recency (word lst)
  (cons word (my-remove word lst))
)

(defun my-remove (word lst)
  (cond ((eq nil lst)        nil)
        ((eq word (car lst)) (cdr lst))
        (t                   (cons (car lst) (remove word (cdr lst))))
  )
)

;; test plan for sort-by-recency:  
;; test case                                data                 expected result      
;; -----------------------------------------------------------------------------
;; empty list                               a, ()               (a)
;; singleton of word                        a, (a)              (a)
;; singleton not of word                    a, (b)              (a b)
;; list containing word at front            a, (a b c)          (a b c)
;; list containing word not at front        a, (b a c)          (a b c)
;; list not containing word                 a, (b c)            (a b c)
;;
;; test plan for my-remove: 
;; test case                                data                 expected result      
;; -----------------------------------------------------------------------------
;; empty list                               a,()                 ()
;; singleton of word                        a,(a)                ()
;; singleton not of word                    a,(b)                (b)
;; list containing word at front            a,(a b c)            (b c)
;; list containing word not at front        a,(b a c)            (b c)
;; list not containing word                 a,(b c)              (b c)