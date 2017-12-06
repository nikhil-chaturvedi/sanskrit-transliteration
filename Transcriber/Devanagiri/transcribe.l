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
#include "DevEncode.h"

using namespace std;

DevEncode devEncoder;
%}

ws          [ \t]+
vyanjan     [\xE0][\xA4][\x95-\xB9]
swar        [\xE0]([\xA4][\x84-\x94]|[\xA5][\xA0-\xA1])
halant      [\xE0][\xA5][\x8D]
chandra     [\xE0][\xA4][\x81]
avagrah     [\xE0][\xA4][\xBD]
anuswar     [\xE0][\xA4][\x82]
visarga     [\xE0][\xA4][\x83]
nukta       [\xE0][\xA4][\xBC]
uddat       [\xE0][\xA5][\x91]
anuddat     [\xE0][\xA5][\x92]
viram       [\xE0][\xA5][\xA4-\xA5]
numbers     [\xE0][\xA5][\xA6-\xAF]
maatra      [\xE0](([\xA4][\xBE-\xBF])|([\xA5][\x80-\x8C])|([\xA5][\xA2-\xA3]))
punctuation [~`!@#$%&_+=|:;'<>,./?\*\^\\\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Dev"

%%
\n                          return -2;
{ws}                        return devEncoder.encodeVyanjan(yytext, yyleng, true);
{viram}                     return devEncoder.encodePunctuation(yytext, yyleng);
{swar}                      return devEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return devEncoder.encodeVyanjan(yytext, yyleng, true);
{avagrah}                   return devEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return devEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return devEncoder.encodeVyanjan(yytext, yyleng, true);
{uddat}                     return devEncoder.encodeVyanjan(yytext, yyleng, true);
{anuddat}                   return devEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{maatra}?          return devEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return devEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{maatra}    return devEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{halant}           return devEncoder.encodeVyanjan(yytext, yyleng, false, true);
{numbers}                   return devEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return devEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("");
%%