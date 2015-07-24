#!/bin/perl6
use v6;
grammar JSIP {
    token TOP       { \s* \(\s* (defclass||definterface) \s+
                            (<[a..z A..Z]> <[a..z A..Z 0..9 _]>*) \s+
                            [<modifiers> \s+]?       <TOPsexp>* % \s*
                            \s*\) \s* }
    token TOPsexp   { \(\s* [<defvar> || <defun> || <defsig> || <import>] \s*\) }
    token import    { [import]         \s+ (\* || <[a..z A..Z]> <[a..z A..Z 0..9 _]>*)* % \. }
    token defvar    { [defvar]         \s+ <bareword> \s+ [<modifiers> \s+]? \(
                          ( \s* \(     \s* <bareword> \s+ <value> [\s+ <get_set>]? \s* \) \s*
                            ||         \s* <bareword>[\s+ <get_set>]? \s* )* \) }
    token defsig    { [defsig]         \s+ <bareword> \s+ <signature> [\s+ <abstract>]? }
    token signature { \(\s* ([<null>   \s+ \. \s+ <bareword> || <bareword> [\s+ \. \s+ <bareword>]*]) \s*\) }
    token defun     { [defun]   \s+    <bareword> \s+ <list> \s+ [<string> \s+]?
                      [<modifiers> \s+]? <sexp>+ % \s+ }

    token sexp      { \(\s* <bareword>+ [\s+ <value>|| \s+ <sexp>]* \s*\) }
    token lambda    { \(\s* [lambda||λ] \s+ <list> [\s+ <bareword>||[\s+ <sexp>]*] \s*\) }

    token list      { <null>     || \(\s* <listthings> \s*\) }
    token null      { \(\)       || null }
    token listthings{ <bareword> || \(\s* <bareword> (\s+ <value>)? \s*\) }
    token value     { <bareword> || <num> || <string> || <char> || <lambda> || <list> }
    token num       { (<[0..9]>+)   (\. <[0..9]>+)? }
    token string    { '"' [<-[\\"]>* [\\.]*]* '"' }
    token char      { "'" [.||\\u [. ** 4]||\\.] "'" }
    token bareword  { <[a..z A..Z ]> <[a..z A..Z 0..9 _ \. \/ ]>* }

    token modifiers { <visibility>\s+ <abs_final> || <visibility> || <abs_final> }
    token visibility{ \: (public||package||protected||private) }
    token abs_final { <final>      || <abstract> }
    token final     { ':final' }
    token abstract  { ':abstract' }
    token get_set   { || <getter> \s+ <setter> || <setter> \s+ <getter>
                      || <getter> || <setter> }
    token getter    { ':getter' }
    token setter    { ':setter' }
}
sub MAIN($str) { JSIP.parse($str).say }
