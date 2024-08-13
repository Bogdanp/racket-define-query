#lang racket/base

(require db
         db/define-query
         rackunit)

(define-query-definer define-query "define-query-queries")

(define-query
  select-42)

(define define-query-suite
  (test-suite
   "define-query"

   (test-case "use a defined query"
     (let ([conn (sqlite3-connect #:database 'memory)])
       (check-equal? (query-value conn select-42) 42)))))

(module+ test
  (require rackunit/text-ui)
  (run-tests define-query-suite))
