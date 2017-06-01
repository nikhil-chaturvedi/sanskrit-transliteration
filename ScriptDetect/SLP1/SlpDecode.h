//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_SLPDECODE_H
#define TRANSCRIBER_SLPDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class SlpDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    SlpDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_SLPDECODE_H
