//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_IASDECODE_H
#define TRANSCRIBER_IASDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class IasDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    IasDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_IASDECODE_H
