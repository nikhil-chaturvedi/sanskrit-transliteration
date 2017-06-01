//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_GUJDECODE_H
#define TRANSCRIBER_GUJDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class GujDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    GujDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_GUJDECODE_H
