# My Emacs Config #

## Overall Strategy ##

The `init.el` file attempts to be declarative, setting custom key
bindings and loading packages.  Any custom functions I write will live
in the `rwt-lisp/` directory.

I will pseudo-namespace my functions with an `rwt/` prefix.  I wish
elisp had better namespacing, but it just doesn't.

## Modules in rwt-lisp/ ##

 - **rwt-utils** has miscellaneous functions.
   - `rwt/delete-around-point` is a way to get vim's `di(/ci(` behavior,
     where you specify a delimiter and it deletes the text inside that
     delimiter, allowing you to change it if you want.  It understands
     nesting delimiters.
 - **rwt-blogging** has code to make my jekyll blogging experience
   smoother.

