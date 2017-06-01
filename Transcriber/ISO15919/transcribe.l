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
#include "IsoEncode.h"

using namespace std;

IsoEncode isoEncoder;
%}

ws          [ \t]+
vyanjan     ([kgcjtdnpbmyrlvsh]|ṅ|ñ|ṭ|ḍ|ṇ|ś|ṣ|([kgcjtdpb]|ṭ|ḍ)[h])
swar        ([aiu]|ā|ī|ū|ē|ō|r̥|r̥̄|l̥|l̥̄|[a][iu])
chandra     m̐
anuswar     ṁ
visarga     ḥ
nukta       [*]
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'*<>,.~?\(\)\{\}\[\}\"/\\]


%option noyywrap c++
%option prefix="Iso"

%%
{ws}                        return isoEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return isoEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return isoEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return isoEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return isoEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}                   return isoEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}             return isoEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return isoEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{swar}      return isoEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return isoEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return isoEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%