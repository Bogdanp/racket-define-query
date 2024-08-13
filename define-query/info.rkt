#lang info

(define license 'BSD-3-Clause)
(define collection "db")
(define deps
  '("base"
    "define-query-lib"))
(define build-deps
  '("db-lib"
    "db-doc"
    "racket-doc"
    "scribble-lib"))
(define implies
  '("define-query-lib"))
(define scribblings
  '(("scribblings/define-query.scrbl")))
