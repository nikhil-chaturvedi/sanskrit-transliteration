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
#include "TelEncode.h"

using namespace std;

TelEncode telEncoder;
%}

ws          [ \t]+
vyanjan     [\xE0][\xB0][\x95-\xB9]
swar        [\xE0][\xB0][\x84-\x94]
halant      [\xE0][\xB1][\x8D]
chandra     [\xE0][\xB0][\x81]
anuswar     [\xE0][\xB0][\x82]
visarga     [\xE0][\xB0][\x83]
nukta       [\xE0][\xB0][\xBC]
viram       [\xE0][\xA5][\xA4-\xA5]
numbers     [\xE0][\xB1][\xA6-\xAF]
maatra      [\xE0](([\xB0][\xBE-\xBF])|([\xB1][\x80-\x8C]))
punctuation [~`!@#$%&_+=|:;'<>,./?\*\^\\\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Tel"

%%
{ws}                        return telEncoder.encodeVyanjan(yytext, yyleng, true);
{viram}                     return telEncoder.encodePunctuation(yytext, yyleng);
{swar}                      return telEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return telEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return telEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return telEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{maatra}?          return telEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return telEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{maatra}    return telEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{halant}           return telEncoder.encodeVyanjan(yytext, yyleng, false, true);
{numbers}                   return telEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return telEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%