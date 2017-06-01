//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#ifndef TRANSCRIBER_ITRENCODE_H
#define TRANSCRIBER_ITRENCODE_H

#include "../Resources/WordMap.h"

class ItrEncode {
    WordMap* vyanjan;
    WordMap* swar;
    WordMap* maatra;
    WordMap* punctuation;
    WordMap* number;

public:
    ItrEncode();
    short int encodeVyanjan(char* str, unsigned long length, bool special = false);
    short int encodeSwar(char* str, unsigned long length);
    short int encodePunctuation(char* str, unsigned long length);
    short int encodeNumber(char* str, unsigned long length);
};


#endif //TRANSCRIBER_ITRENCODE_H
