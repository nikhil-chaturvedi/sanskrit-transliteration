//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#include "ItrDecode.h"

ItrDecode::ItrDecode() {
    string folder = "ITRANS/Maps/";
    this->vyanjan = new CodeMap(3, 3, folder + "vyanjan.txt");
    this->swar = new CodeMap(3, 2, folder + "swar.txt");
    this->maatra = new CodeMap(3, 2, folder + "maatra.txt");
    this->punctuation = new CodeMap(3, 2, folder + "punctuation.txt");
    this->number = new CodeMap(3, 2, folder + "number.txt");
}

string ItrDecode::decode(short int code) {
    short int swar = code & (short int)0x1f;
    short int vyanjan = (code >> 5) & (short int)0x3f;

    if (vyanjan == (short int)0x3f)
        return this->swar->lookup(swar);

    switch (vyanjan) {
        case 50:
        case 51:
        case 52:
        case 53:
        case 57:
            return this->vyanjan->lookup(vyanjan);
        case 58:
            return this->punctuation->lookup(swar);
        case 59:
            return this->number->lookup(swar);
    }

    string decoded("");

    decoded += this->vyanjan->lookup(vyanjan);

    decoded += (swar == (short int)0x1f)? "" : this->maatra->lookup(swar);
    return decoded;
}