#lang racket
(define (visit-doctor name) 
   ( (write (list 'hello name)) 
    (write '(what seems to be the trouble?)) 
    (doctor-driver-loop name)))
 
(define doctor-driver-loop
         (lambda (name)
           ((display "\n")
           (display '**)
           (let ((user-response (read)))
             (cond
                 ( (equal? user-response '(goodbye))
                      (write (list 'goodbye name))
                )
                 (else
                  (go-on name user-response )
                  ))))))
         
(define go-on
  (lambda (name user-response)
((write (reply user-response))
                  (doctor-driver-loop name))))
 
(define (reply user-response) 
    (cond ((fifty-fifty)
        (append (qualifier) 
        (change-person user-response))) 
    (else (hedge))))

(define (fifty-fifty) (= (random 2) 0))

 (define (qualifier) 
    (pick-random '
    ((you seem to think) 
     (you feel that) 
     (why do you believe) 
     (why do you say)

     (why do you feel that)
     (what do you feel when)
     (tell me more about)
     (so you think that)
     (apparently you think)
    ))) 
 
(define (hedge) 
    (pick-random '
    ((please go on) 
     (many people have the same sorts of feelings) 
     (many of my patients have told me the same thing) 
     (please continue)
     
     (interesting go on)
     (I understand how you feel)
     (tell me more)
     (you're not the only one with these feelings)
     (you'll feel better if you talk about it)
    )))

; by iterating the words instead of the replacement pairs the bug can be fixed 
(define (replaceN replace-pairs word)
  (cond ((null? replace-pairs) word)
        ((equal? (caar replace-pairs) word)
          (cdar replace-pairs))
  (else (replaceN (cdr replace-pairs) word))))

(define (replace-manyN replace-pairs word-list)
  (cond ((null? word-list) '())
  (else (let ((w (replaceN replace-pairs (car word-list))))
          (cons w (replace-manyN replace-pairs (cdr word-list)))
          )))
  )

(define (replace pattern replacement lst) 
    (cond ((null? lst) '()) 
        ((equal? (car lst) pattern) 
         (cons replacement (replace pattern replacement (cdr lst)))
        ) 
    (else 
        (cons (car lst) (replace pattern replacement (cdr lst))))))

                     
(define (many-replace replacement-pairs lst) 
    (cond ((null? replacement-pairs) lst) 
    (else 
        (let
          ((pat-rep (car replacement-pairs))) 
          (replace (car pat-rep) (cadr pat-rep) (many-replace (cdr replacement-pairs) lst)))
        )
    )
  )

(define (change-person phrase)
    ; the bug is, that for example 'you' gets replaced by 'i' and then 'i' gets replaced by 'you' again.
    ; so it depends on the order how the replacement rules appear (the first one 'wins')
    (replace-manyN '((i you) (me you) (am are) (my your) (are am) (your my) (you i))
    phrase) )

(define (pick-random lst)
    (nth (+ 0 (random (length lst) ) ) lst) )

(define (nth n lst)
   (cond
   ((empty? lst) null)
   ((= n 0)
   (car lst))
  (else
    (nth (- n 1) (cdr lst)))))

