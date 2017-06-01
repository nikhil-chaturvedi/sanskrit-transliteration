//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_ITRDECODE_H
#define TRANSCRIBER_ITRDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class ItrDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    ItrDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_ITRDECODE_H
