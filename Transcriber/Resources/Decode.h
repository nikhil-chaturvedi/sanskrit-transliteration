//
// Created by Nikhil Chaturvedi on 30/05/17.
//

#ifndef TRANSCRIBER_DECODE_H
#define TRANSCRIBER_DECODE_H

#include <string>

using namespace std;

class Decode {
public:
    virtual ~Decode() {};
    virtual string decode(short int code) = 0;
};

#endif //TRANSCRIBER_DECODE_H
