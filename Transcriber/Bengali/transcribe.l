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
#include "BenEncode.h"

using namespace std;

BenEncode benEncoder;
%}

ws          [ \t]+
vyanjan     [\xE0]([\xA6][\x95-\xB9]|[\xA7][\xB1])
swar        [\xE0][\xA6][\x84-\x94]
halant      [\xE0][\xA7][\x8D]
chandra     [\xE0][\xA6][\x81]
anuswar     [\xE0][\xA6][\x82]
visarga     [\xE0][\xA6][\x83]
nukta       [\xE0][\xA6][\xBC]
viram       [\xE0][\xA5][\xA4]
numbers     [\xE0][\xA7][\xA6-\xAF]
maatra      [\xE0](([\xA6][\xBE-\xBF])|([\xA7][\x80-\x8C]))
punctuation [~`!@#$%&_+=|:;'<>,./?\*\^\\\(\)\{\}\[\}\"]


%option noyywrap c++
%option prefix="Ben"

%%
{ws}                        return benEncoder.encodeVyanjan(yytext, yyleng, true);
{viram}                     return benEncoder.encodePunctuation(yytext, yyleng);
{swar}                      return benEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return benEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return benEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return benEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{maatra}?          return benEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return benEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{maatra}    return benEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{halant}           return benEncoder.encodeVyanjan(yytext, yyleng, false, true);
{numbers}                   return benEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return benEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%