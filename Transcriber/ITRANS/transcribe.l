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
#include "ItrEncode.h"

using namespace std;

ItrEncode itrEncoder;
%}

ws          [ \t]+
vyanjan     ([kgjTDNtdnpbmyrlvsh]|[kgcCjTDdtpbsS][h]|[~][nN])
swar        ([aiuoe]|[a][aiu]|[u][u]|[i][i]|[R][R][iI]|[L][L][iI])
chandra     [.][N]
anuswar     [M]
visarga     [H]
nukta       [*]
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'\^<>,.~?\(\)\{\}\[\}\"/\\]


%option noyywrap c++
%option prefix="Itr"

%%
{ws}                        return itrEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return itrEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return itrEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return itrEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return itrEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}                   return itrEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}             return itrEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return itrEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{swar}      return itrEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return itrEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return itrEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%