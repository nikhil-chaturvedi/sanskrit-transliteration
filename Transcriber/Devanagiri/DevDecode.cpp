//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#include "DevDecode.h"

DevDecode::DevDecode() {
    string folder = "Devanagiri/Maps/";
    this->vyanjan = new CodeMap(3, 3, folder + "vyanjan.txt");
    this->swar = new CodeMap(3, 2, folder + "swar.txt");
    this->maatra = new CodeMap(3, 2, folder + "maatra.txt");
    this->punctuation = new CodeMap(3, 2, folder + "punctuation.txt");
    this->number = new CodeMap(3, 2, folder + "number.txt");
}

string DevDecode::decode(short int code) {
    short int swar = code & (short int)0x1f;
    short int vyanjan = (code >> 5) & (short int)0x3f;

    if (vyanjan == (short int)0x3f)
        return this->swar->lookup(swar);

    switch (vyanjan) {
        case 48:
        case 49:
        case 50:
        case 51:
        case 52:
        case 53:
        case 57:
            return this->vyanjan->lookup(vyanjan);
        case 58:
            return (swar == 0x0)? "।" : this->punctuation->lookup(swar);
        case 59:
            return this->number->lookup(swar);
    }

    string decoded("");

    decoded += this->vyanjan->lookup(vyanjan);

    if (swar == 0)
        return decoded;

    decoded += (swar == (short int)0x1f)? "्" : this->maatra->lookup(swar);
    return decoded;
}