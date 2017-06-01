/*
 * Sample Scanner1:
 * Description: Replace the string "username" from standard input
 *              with the user's login name (e.g. lgao)
 * Usage: (1) $ flex sample1.lex
 *        (2) $ gcc lex.yy.c -ll
 *        (3) $ ./a.out
 *            stdin> username
 *	      stdin> Ctrl-D
 * Question: What is the purpose of '%{' and '%}'?
 *           What else could be included in this section?
 */

%{
/* need this for the call to getlogin() below */
#include <iostream>
#include <unistd.h>
#include "IpaEncode.h"

using namespace std;

IpaEncode ipaEncoder;
%}

ws          [ \t]+
vyanjan     (k|kʰ|ɡ|ɡʱ|ŋ|tʃ|tʃʰ|dʒ|dʒʱ|ɲ|ʈ|ʈʰ|ɖ|ɖʱ|ɳ|t̪|t̪ʰ|d̪|d̪ʱ|n|p|pʰ|b|bʱ|m|j|r|l|ʋ|ʃ|ʂ|s|ɦ)
swar        (ə|aː|ɪ|iː|ʊ|uː|rː|eː|ɛː|oː|ɔː)
nukta       (q|x|ɣ|z|ɽ|ɽʱ|f)
chandra     m̐
anuswar     ṁ
visarga     ḥ
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'*<>,.~?\(\)\{\}\[\}\"/\\]


%option noyywrap c++
%option prefix="Ipa"

%%
\n                          return -2;
{ws}                        return ipaEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return ipaEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return ipaEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return ipaEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return ipaEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}                   return ipaEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}             return ipaEncoder.encodeVyanjan(yytext, yyleng);
{nukta}                     return ipaEncoder.encodeVyanjan(yytext, yyleng, true);
{nukta}{swar}               return ipaEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return ipaEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return ipaEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%