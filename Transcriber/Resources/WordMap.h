//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#ifndef TRANSCRIBER_WORDMAP_H
#define TRANSCRIBER_WORDMAP_H

#include <unordered_map>
#include <string>

using namespace std;

class WordMap {
    unordered_map<string, short int> encoding;
    int numRows;
    int numColumns;
    int numBits;

public:
    WordMap(int rowBits, int columnBits, string filename);
    void populateMap(string filename);
    int lookup(string key);
};


#endif //TRANSCRIBER_WORDMAP_H
