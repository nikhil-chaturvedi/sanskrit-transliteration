//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#include <cstdlib>
#include "OriEncode.h"

OriEncode::OriEncode() {
    string folder = "Oriya/Maps/";
    this->vyanjan = new WordMap(3, 3, folder + "vyanjan.txt");
    this->swar = new WordMap(3, 2, folder + "swar.txt");
    this->maatra = new WordMap(3, 2, folder + "maatra.txt");
    this->punctuation = new WordMap(3, 2, folder + "punctuation.txt");
    this->number = new WordMap(3, 2, folder + "number.txt");
}

short int OriEncode::encodeVyanjan(char *str, unsigned long length, bool special, bool halant) {
    short int encoding = 0;
    string toEncode(str);
    if (length == 1 && special) {
        encoding |= 0x1f;
        encoding |= this->vyanjan->lookup(toEncode) << 5;
        return encoding;
    }
    if (length != 3 && length != 6 && length != 9) {
        printf("Error in tokenisation!");
        exit(0);
    }
    if (length == 3 || (length == 6 && halant)) {
        if (special || halant)
            encoding |= 0x1f;
        encoding |= this->vyanjan->lookup(toEncode.substr(0, 3)) << 5;
        return encoding;
    }
    if (length == 6 && special) {
        encoding |= this->vyanjan->lookup(toEncode) << 5;
        return encoding;
    }
    encoding |= this->maatra->lookup(toEncode.substr(length-3, 3));
    encoding |= this->vyanjan->lookup(toEncode.substr(0, length-3)) << 5;
    return encoding;
}

short int OriEncode::encodeSwar(char *str, unsigned long length) {
    short int encoding = 0;
    string toEncode(str);
    if (length != 3) {
        printf("Error in tokenisation!");
        exit(0);
    }
    encoding |= this->swar->lookup(toEncode);
    encoding |= 0x3f << 5;
    return encoding;
}

short int OriEncode::encodePunctuation(char *str, unsigned long length) {
    short int encoding = 0;
    string toEncode(str);
    if (length == 3) {
        encoding |= 0x3a << 5;
        return encoding;
    }
    if (length != 1) {
        printf("Error in tokenisation!");
        exit(0);
    }
    encoding |= this->punctuation->lookup(toEncode);
    encoding |= 0x3a << 5;
    return encoding;
}

short int OriEncode::encodeNumber(char *str, unsigned long length) {
    short int encoding = 0;
    string toEncode(str);
    if (length != 3) {
        printf("Error in tokenisation!");
        exit(0);
    }
    encoding |= this->number->lookup(toEncode);
    encoding |= 0x3b << 5;
    return encoding;
}