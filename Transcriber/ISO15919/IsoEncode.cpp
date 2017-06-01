//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#include <cstdlib>
#include "IsoEncode.h"

IsoEncode::IsoEncode() {
    string folder = "ISO15919/Maps/";
    this->vyanjan = new WordMap(3, 3, folder + "vyanjan.txt");
    this->swar = new WordMap(3, 2, folder + "swar.txt");
    this->maatra = new WordMap(3, 2, folder + "maatra.txt");
    this->punctuation = new WordMap(3, 2, folder + "punctuation.txt");
    this->number = new WordMap(3, 2, folder + "number.txt");
}

short int IsoEncode::encodeVyanjan(char *str, unsigned long length, bool special) {
    short int encoding = 0;
    string toEncode(str);
    //printf("Token: %s\n", toEncode.c_str());
    /*if (length != 1 && length != 2 && length != 3) {
        printf("Error in tokenisation!");
        exit(0);
    }*/
    if ( special ) {
        encoding |= 0x1f;
        encoding |= this->vyanjan->lookup(toEncode) << 5;
        return encoding;
    }
    int found = std::string::npos;
    int index = 0;
    string swars[] = {"a","i","u","ā","ī","ē","r̥","r̥̄","l̥","l̥̄","ō","ū"};
    while (found == std::string::npos) {
        found = toEncode.find(swars[index]);
        index++;
    }
    //printf("Found: %d\n", found);
    encoding |= this->maatra->lookup(toEncode.substr(found));
    encoding |= this->vyanjan->lookup(toEncode.substr(0, found)) << 5;
    return encoding;
}

short int IsoEncode::encodeSwar(char *str, unsigned long length) {
    short int encoding = 0;
    string toEncode(str);
    /*if (length != 1) {
        printf("Error in tokenisation!");
        exit(0);
    }*/
    encoding |= this->swar->lookup(toEncode);
    encoding |= 0x3f << 5;
    return encoding;
}

short int IsoEncode::encodePunctuation(char *str, unsigned long length) {
    short int encoding = 0;
    string toEncode(str);
    if (length != 1) {
        printf("Error in tokenisation!");
        exit(0);
    }
    encoding |= this->punctuation->lookup(toEncode);
    encoding |= 0x3a << 5;
    return encoding;
}

short int IsoEncode::encodeNumber(char *str, unsigned long length) {
    short int encoding = 0;
    string toEncode(str);
    if (length != 1) {
        printf("Error in tokenisation!");
        exit(0);
    }
    encoding |= this->number->lookup(toEncode);
    encoding |= 0x3b << 5;
    return encoding;
}