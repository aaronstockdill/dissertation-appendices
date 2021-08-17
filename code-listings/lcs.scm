(import vector-lib)

(define (lcs xstring ystring)
  (define (make-table x y v)
    (vector-unfold (lambda (i) (make-vector y v)) x))
  (let* ((xl (string-length xstring))
         (yl (string-length ystring))
         (table (make-table (+ 1 xl) (+ 1 yl) 0)))
    (define (get-index i j)
      (vector-ref (vector-ref table i) j))
    (define (set-index i j v)
      (vector-set! (vector-ref table i) j v))
    (define (loop-inner i j)
      (unless (eq? j (+ yl 1))
        (if (eq? (string-ref xstring (- i 1)) (string-ref ystring (- j 1)))
            (set-index i j (+ 1 (get-index (- i 1) (- j 1))))
            (set-index i j (max (get-index i (- j 1)) (get-index (- i 1) j))))
        (loop-inner i (+ j 1))))
    (define (loop-outer i)
      (unless (eq? i (+ xl 1))
        (loop-inner i 1)
        (loop-outer (+ i 1))))
    (loop-outer 1)
    (define (reconstruct sln k i j)
      (if (eq? k 0)
          (list->string sln)
          (cond ((eq? (string-ref xstring (- i 1)) (string-ref ystring (- j 1)))
                 (reconstruct (cons (string-ref xstring (- i 1)) sln)
                              (- k 1) (- i 1) (- j 1)))
                ((> (get-index i (- j 1)) (get-index (- i 1) j))
                 (reconstruct sln k i (- j 1)))
                (else
                 (reconstruct sln k (- i 1) j)))))
    (reconstruct '() (get-index xl yl) xl yl)))


(display (lcs "1234" "1224533324"))
(display "\n")

(display (lcs "thisisatest" "testing123testing"))
(display "\n")