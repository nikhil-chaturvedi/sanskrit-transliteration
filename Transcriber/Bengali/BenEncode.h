//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#ifndef TRANSCRIBER_BENENCODE_H
#define TRANSCRIBER_BENENCODE_H

#include "../Resources/WordMap.h"

class BenEncode {
    WordMap* vyanjan;
    WordMap* swar;
    WordMap* maatra;
    WordMap* punctuation;
    WordMap* number;

public:
    BenEncode();
    short int encodeVyanjan(char* str, unsigned long length, bool special = false, bool halant = false);
    short int encodeSwar(char* str, unsigned long length);
    short int encodePunctuation(char* str, unsigned long length);
    short int encodeNumber(char* str, unsigned long length);
};


#endif //TRANSCRIBER_BENENCODE_H
