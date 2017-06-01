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
#include "OriEncode.h"

using namespace std;

OriEncode oriEncoder;
%}

ws          [ \t]+
vyanjan     [\xE0][\xAC][\x95-\xB9]
swar        [\xE0][\xAC][\x84-\x94]
halant      [\xE0][\xAD][\x8D]
chandra     [\xE0][\xAC][\x81]
anuswar     [\xE0][\xAC][\x82]
visarga     [\xE0][\xAC][\x83]
nukta       [\xE0][\xAC][\xBC]
viram       [\xE0][\xA5][\xA4-\xA5]
numbers     [\xE0][\xAD][\xA6-\xAF]
maatra      [\xE0](([\xAC][\xBE-\xBF])|([\xAD][\x80-\x8C]))
punctuation [~`!@#$%&_+=|:;'<>,./?\*\^\\\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Ori"

%%
{ws}                        return oriEncoder.encodeVyanjan(yytext, yyleng, true);
{viram}                     return oriEncoder.encodePunctuation(yytext, yyleng);
{swar}                      return oriEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return oriEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return oriEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return oriEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{maatra}?          return oriEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return oriEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{maatra}    return oriEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{halant}           return oriEncoder.encodeVyanjan(yytext, yyleng, false, true);
{numbers}                   return oriEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return oriEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%