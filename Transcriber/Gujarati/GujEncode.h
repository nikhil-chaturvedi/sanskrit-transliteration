//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#ifndef TRANSCRIBER_GUJENCODE_H
#define TRANSCRIBER_GUJENCODE_H

#include "../Resources/WordMap.h"

class GujEncode {
    WordMap* vyanjan;
    WordMap* swar;
    WordMap* maatra;
    WordMap* punctuation;
    WordMap* number;

public:
    GujEncode();
    short int encodeVyanjan(char* str, unsigned long length, bool special = false, bool halant = false);
    short int encodeSwar(char* str, unsigned long length);
    short int encodePunctuation(char* str, unsigned long length);
    short int encodeNumber(char* str, unsigned long length);
};


#endif //TRANSCRIBER_GUJENCODE_H
