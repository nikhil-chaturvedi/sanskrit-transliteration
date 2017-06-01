//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_TELDECODE_H
#define TRANSCRIBER_TELDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class TelDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    TelDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_TELDECODE_H
