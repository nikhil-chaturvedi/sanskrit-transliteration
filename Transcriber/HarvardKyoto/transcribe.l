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
#include "HarEncode.h"

using namespace std;

HarEncode harEncoder;
%}

ws          [ \t]+
vyanjan     ([kgGcjJTDNtdnpbmyrlvzSsh]|[kgcjTDtdpb][h])
swar        ([aAiIuUeoR]|[a][iu]|[R][R]|[I][R]|[I][R][R])
chandra     [\^]
anuswar     [M]
visarga     [H]
nukta       [*]
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'*<>,.~?\(\)\{\}\[\}\"/\\]


%option noyywrap c++
%option prefix="Har"

%%
{ws}                        return harEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return harEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return harEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return harEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return harEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}                   return harEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}             return harEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return harEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{swar}      return harEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return harEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return harEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%