//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_ORIDECODE_H
#define TRANSCRIBER_ORIDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class OriDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    OriDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_ORIDECODE_H
