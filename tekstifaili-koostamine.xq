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
declare namespace eki = "http://www.eki.ee/dict";
declare option output:omit-xml-declaration "yes";
declare option output:method "xhtml";

(:~
 : Ss for creating simple wordlists for flashchards by 
 : extracting categorised words from the Basic Dictionary of
 : Estonian Language and other EKI dictionary sources.
 : 
 : Current drawbacks:
 : * The output follows alphabetic order of the headwords
 : * The simplistic CSV text is outputted directly to stdout
 :)

declare
function eki:psv-flash-definiton-headword(
  $sem-group as xs:string,
  $pos as xs:string
)
{ 
  (: Declare Base URL for headword links :)
  let $link := 'http://eki.ee/dict/psv/index.cgi?Q='
  (: Return all adjectives for physical qualities :)
  let $articles := eki:psv-articles($sem-group, $pos)
  
  for $article in $articles
    let $definitions := $article//psv:d
    let $headwords   := $article//psv:m
      for $definition in $definitions
        let $front := $definition/text()
        for $headword in $headwords
          let $back := <a href="{concat($link, $headword/text())}">{$headword/text()}</a>
          return ($front, out:tab(), $back, out:nl())
};

declare
function eki:psv-flash-headword-transl(
  $sem-group as xs:string,
  $pos as xs:string
)
{
  (: Declare Base URL for headword links :)
  let $link := 'http://eki.ee/dict/psv/index.cgi?Q='
  let $articles := eki:psv-articles($sem-group, $pos)
  for $headword in distinct-values($articles//psv:m/text())
    let $back :=  <a href="{concat($link, $headword)}">{$headword}</a>
    let $translations := distinct-values(eki:get-ru($headword))
    return 
      if(not(empty($translations)))
      then($translations, out:tab(), $back, out:nl())
      else()
};

declare
function eki:csv(
  $front as xs:string,
  $back as xs:string
)
{
  ($front, out:tab(), $back, out:nl())
};

declare
function eki:psv-articles($sem-group as xs:string, $pos as xs:string)
{
  let $articles := db:open('psv1')//psv:A[
      (some $sl in .//psv:sl satisfies starts-with($sl, $pos))
      and
      (some $semg in .//psv:semg satisfies starts-with($semg, $sem-group))
    ]
  return $articles
};

declare
function eki:psv-sem-categories()
{
  distinct-values(db:open('psv1')//psv:semg/data())
};

declare
function eki:psv-pos()
{
  distinct-values(db:open('psv1')//psv:sl/data())
};

declare
function eki:get-ru($headword as xs:string)
{
  db:open('evs')//*:m[. = $headword]/ancestor::*:A//*:x
};


eki:psv-flash-headword-transl('nähtus_loodus', 'S')

(:eki:get-ru('kaamel') :)