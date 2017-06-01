//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#ifndef TRANSCRIBER_DEVENCODE_H
#define TRANSCRIBER_DEVENCODE_H

#include "../Resources/WordMap.h"

class DevEncode {
    WordMap* vyanjan;
    WordMap* swar;
    WordMap* maatra;
    WordMap* punctuation;
    WordMap* number;

public:
    DevEncode();
    short int encodeVyanjan(char* str, unsigned long length, bool special = false, bool halant = false);
    short int encodeSwar(char* str, unsigned long length);
    short int encodePunctuation(char* str, unsigned long length);
    short int encodeNumber(char* str, unsigned long length);
};


#endif //TRANSCRIBER_DEVENCODE_H
