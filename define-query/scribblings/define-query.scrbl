#lang scribble/manual

@(require (for-label db
                     db/define-query
                     racket/base
                     racket/runtime-path))

@title{@tt{define-query}}
@author[(author+email "Bogdan Popa" "bogdan@defn.io")]
@defmodule[db/define-query]

This module provides utilities for turning @filepath{.sql} files into
@racket[virtual-statement]s in a way that cooperates with @tt{raco
dist}.

@defform[
  (define-query-definer define-id path-expr)
  #:contracts ([path-expr (or/c path? path-string?)])
]{

  Binds @racket[define-id] as a form that defines queries by referencing
  @filepath{.sql} files located at @racket[path-expr]. The referenced
  files are automatically bundled together with an application during
  distribution (à la @racket[define-runtime-path]).

  The syntax of @racket[define-id] is:

  @defsubform[
    (define-id binder ...+)
    #:grammar ([binder (code:line query-id)
                       (code:line [query-id filename-expr])])
    #:contracts ([filename-expr path-string?])
  ]

  A @racket[define-id] form binds the @racket[query-id]s by loading the
  contents of their associated files (relative to @racket[path-expr])
  at runtime and passing those contents to @racket[virtual-statement].
  If a @racket[filename-expr] is not provided for a binder, it defaults
  to the result of appending @filepath{.sql} to the string version of
  @racket[query-id].

  For example:

  @racketblock[
    (define-query-definer define-metadata-query
      "metadata-queries")
    (define-metadata-query
      get-metadata
      put-metadata)
    (query-exec db-conn put-metadata "example" 42)
    (query-value db-conn get-metadata "example")
  ]
}
