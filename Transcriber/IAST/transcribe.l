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
#include "IasEncode.h"

using namespace std;

IasEncode iasEncoder;
%}

ws          [ \t]+
vyanjan     ([kgcjtdnpbmyrlvsh]|ṅ|ñ|ṭ|ḍ|ṇ|ś|ṣ|([kgcjtdpb]|ṭ|ḍ)[h])
swar        ([aiu]|ā|ī|ū|ē|ō|ṝ|ṛ|ḷ|ḹ|[a][iu])
chandra     m̐
anuswar     ṃ
visarga     ḥ
nukta       [*]
numbers     [0-9]
punctuation [`!@#$%&_+=|:;'*<>,.~?\(\)\{\}\[\}\"/\\]


%option noyywrap c++
%option prefix="Ias"

%%
{ws}                        return iasEncoder.encodeVyanjan(yytext, yyleng, true);
{swar}                      return iasEncoder.encodeSwar(yytext, yyleng);
{chandra}                   return iasEncoder.encodeVyanjan(yytext, yyleng, true);
{anuswar}                   return iasEncoder.encodeVyanjan(yytext, yyleng, true);
{visarga}                   return iasEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}                   return iasEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{swar}             return iasEncoder.encodeVyanjan(yytext, yyleng);
{vyanjan}{nukta}            return iasEncoder.encodeVyanjan(yytext, yyleng, true);
{vyanjan}{nukta}{swar}      return iasEncoder.encodeVyanjan(yytext, yyleng);
{numbers}                   return iasEncoder.encodeNumber(yytext, yyleng);
{punctuation}               return iasEncoder.encodePunctuation(yytext, yyleng);
<<EOF>>                     return -1;
.                           printf("Unknown: %s\n", yytext);
%%