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
#include "VelEncode.h"

using namespace std;

VelEncode velEncoder;
%}

ws          [ \t]+
vyanjan     ([kgcjtdnpbmyrlvsh]|[kgcjtdpb][h]|[.][tdns]|[.][td][h]|[~][n]|[\"][ns])
swar        ([aiuoe]|[a][aiu]|[u][u]|[i][i]|[.][rl]|[.][r][r]|[.][l][l])
chandra     [\^]
anuswar     [.][m]
visarga     [.][h]
nukta       [*]
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'<>,.~?\(\)\{\}\[\}\"/\\]


%option noyywrap c++
%option prefix="Vel"

%%
\n                          return -2;
{ws}                        return velEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return velEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return velEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return velEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return velEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}                   return velEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}             return velEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return velEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{swar}      return velEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return velEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return velEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%