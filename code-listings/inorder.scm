(define (inorder tree)
  (if (null? tree)
      '()
      (let* ((v (car tree))
             (l (cadr tree))
             (r (caddr tree)))
        (append (inorder l) `(,v) (inorder r)))))


(display (inorder '(4 (2 (1 () ()) (3 () ()))
                      (6 (5 () ()) (7 () ())))))
(display "\n")
