//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_VELDECODE_H
#define TRANSCRIBER_VELDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class VelDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    VelDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_VELDECODE_H
