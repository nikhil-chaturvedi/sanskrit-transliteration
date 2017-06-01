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
#include "GujEncode.h"

using namespace std;

GujEncode gujEncoder;
%}

ws          [ \t]+
vyanjan     [\xE0][\xAA][\x95-\xB9]
swar        [\xE0][\xAA][\x84-\x94]
halant      [\xE0][\xAB][\x8D]
chandra     [\xE0][\xAA][\x81]
anuswar     [\xE0][\xAA][\x82]
visarga     [\xE0][\xAA][\x83]
nukta       [\xE0][\xAA][\xBC]
viram       [\xE0][\xA5][\xA4-\xA5]
numbers     [\xE0][\xAB][\xA6-\xAF]
maatra      [\xE0](([\xAA][\xBE-\xBF])|([\xAB][\x80-\x8C]))
punctuation [~`!@#$%&_+=|:;'<>,./?\*\^\\\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Guj"

%%
{ws}                        return gujEncoder.encodeVyanjan(yytext, yyleng, true);
{viram}                     return gujEncoder.encodePunctuation(yytext, yyleng);
{swar}                      return gujEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return gujEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return gujEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return gujEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{maatra}?          return gujEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return gujEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{maatra}    return gujEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{halant}           return gujEncoder.encodeVyanjan(yytext, yyleng, false, true);
{numbers}                   return gujEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return gujEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%