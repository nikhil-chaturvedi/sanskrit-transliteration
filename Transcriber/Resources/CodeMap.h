//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#ifndef TRANSCRIBER_CODEMAP_H
#define TRANSCRIBER_CODEMAP_H

#include <unordered_map>
#include <string>

using namespace std;

class CodeMap {
    unordered_map<short int, string> decoding;
    int numRows;
    int numColumns;
    int numBits;

public:
    CodeMap(int rowBits, int columnBits, string filename);
    void populateMap(string filename);
    string lookup(short int key);
};


#endif //TRANSCRIBER_CODEMAP_H
