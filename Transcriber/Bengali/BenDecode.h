//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_BENDECODE_H
#define TRANSCRIBER_BENDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class BenDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    BenDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_BENDECODE_H
