//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#ifndef TRANSCRIBER_HARENCODE_H
#define TRANSCRIBER_HARENCODE_H

#include "../Resources/WordMap.h"

class HarEncode {
    WordMap* vyanjan;
    WordMap* swar;
    WordMap* maatra;
    WordMap* punctuation;
    WordMap* number;

public:
    HarEncode();
    short int encodeVyanjan(char* str, unsigned long length, bool special = false);
    short int encodeSwar(char* str, unsigned long length);
    short int encodePunctuation(char* str, unsigned long length);
    short int encodeNumber(char* str, unsigned long length);
};


#endif //TRANSCRIBER_HARENCODE_H
