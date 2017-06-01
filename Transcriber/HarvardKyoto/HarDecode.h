//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_HARDECODE_H
#define TRANSCRIBER_HARDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class HarDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    HarDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_HARDECODE_H
