//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_GURDECODE_H
#define TRANSCRIBER_GURDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class GurDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    GurDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_GURDECODE_H
