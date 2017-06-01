//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_IPADECODE_H
#define TRANSCRIBER_IPADECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class IpaDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    IpaDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_IPADECODE_H
