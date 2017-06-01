//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_DEVDECODE_H
#define TRANSCRIBER_DEVDECODE_H

#include "../Resources/CodeMap.h"
#include "../Resources/Decode.h"

class DevDecode: public Decode {
    CodeMap* vyanjan;
    CodeMap* swar;
    CodeMap* maatra;
    CodeMap* punctuation;
    CodeMap* number;

public:
    DevDecode();
    string decode(short int code);
};


#endif //TRANSCRIBER_DEVDECODE_H
