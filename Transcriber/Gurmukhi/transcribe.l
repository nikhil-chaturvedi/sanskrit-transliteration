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
#include "GurEncode.h"

using namespace std;

GurEncode gurEncoder;
%}

ws          [ \t]+
vyanjan     [\xE0][\xA8][\x95-\xB9]
swar        [\xE0][\xA8][\x84-\x94]
halant      [\xE0][\xA9][\x8D]
chandra     [\xE0][\xA8][\x81]
anuswar     [\xE0][\xA8][\x82]
visarga     [\xE0][\xA8][\x83]
nukta       [\xE0][\xA8][\xBC]
viram       [\xE0][\xA5][\xA4-\xA5]
numbers     [\xE0][\xA9][\xA6-\xAF]
maatra      [\xE0](([\xA8][\xBE-\xBF])|([\xA9][\x80-\x8C]))
punctuation [~`!@#$%&_+=|:;'<>,./?\*\^\\\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Gur"

%%
\n                          return -2;
{ws}                        return gurEncoder.encodeVyanjan(yytext, yyleng, true);
{viram}                     return gurEncoder.encodePunctuation(yytext, yyleng);
{swar}                      return gurEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return gurEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return gurEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return gurEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{maatra}?          return gurEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return gurEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{maatra}    return gurEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{halant}           return gurEncoder.encodeVyanjan(yytext, yyleng, false, true);
{numbers}                   return gurEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return gurEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%