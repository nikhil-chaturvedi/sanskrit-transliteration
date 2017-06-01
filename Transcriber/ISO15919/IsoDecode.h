//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_ISODECODE_H
#define TRANSCRIBER_ISODECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class IsoDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    IsoDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_ISODECODE_H
