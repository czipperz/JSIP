#JSIP

The goal with the language is to keep the "super parenthesis mode" of Lisp while **NOT** adding any extra keywords.

Note that the keywords here **ONLY** used to define top level `sexp`s.
This means that you can use these as variables, no problem.


##Syntax



Example:

    ;;; Animal.jp
    :public :abstract                           ; use descriptors at beginning of class definition
    (defvar String ((name "Rover" :getter)))    ; `private' by default
    (defvar int :private ((age 0 :getter)))     ; `:getter' auto generates a getter `getAge()'

    (defsig birthday (() . void))               ; () == null
    (defun birthday () "Give this person a birthday" :public
           (++ age))

    (defsig eat :abstract ((Food) . void))
    (defsig 
