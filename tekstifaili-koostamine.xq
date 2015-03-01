(:~
 : This module is part of a language learning project at the
 : Institute of the Estonian Language.
 :
 : @author Kristian Kankainen, EKI 2015, GNU GPLv3 License
 : @link http://www.eki.ee/
 :)

xquery version "3.0" encoding "UTF-8";
declare namespace psv = "http://www.eki.ee/dict/psv";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:omit-xml-declaration "yes";
declare option output:method "xhtml";

(:~
 : Simple script for extracting all adjectival words marked as 
 : denoting physical qualities. It comprises 35 words in the
 : EKI Põhisõnavara dictionary. Since headwords can have many
 : descriptions, it totals in 360 flashcard rows.
 : 
 : Current drawbacks:
 : * The output follows alphabetic order of the headwords
 : * The simplistic CSV text is outputted directly to stdout
 :)

(: Base URL for headword links :)
let $link := 'http://eki.ee/dict/psv/index.cgi?Q='
(: Return all adjectives for physical qualities :)
let $articles := //psv:A[
    (some $pos in .//psv:sl satisfies $pos = 'A')
    and
    (some $sem-group in .//psv:semg satisfies $sem-group = 'omadus_füüs')
  ]

for $article in $articles
  let $definitions := $article//psv:d
  let $headwords   := $article//psv:m
    for $definition in $definitions
      let $front := $definition/text()
      for $headword in $headwords
        let $back := <a href="{concat($link, $headword/text())}">{$headword/text()}</a>
          return ($front, out:tab(), $back, out:nl())
