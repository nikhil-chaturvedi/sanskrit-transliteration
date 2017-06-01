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
#include "SlpEncode.h"

using namespace std;

SlpEncode slpEncoder;
%}

ws          [ \t]+
vyanjan     [kKgGNcCjJYwWqQRtTdDnpPbBmyrlvSzsh]
swar        [aAiIuUeEoOfFxX]
chandra     [~]
anuswar     [M]
visarga     [H]
nukta       [*]
uddat       [/]
anuddat     [\\]
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'<>,.?\*\^\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Slp"

%%
\n                          return -2;
{ws}                        return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return slpEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{uddat}                     return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{anuddat}                   return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}?            return slpEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return slpEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{swar}      return slpEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return slpEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return slpEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%