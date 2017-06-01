//
// Created by Nikhil Chaturvedi on 16/03/17.
//

#include "WordMap.h"
#include <fstream>

WordMap::WordMap(int rowBits, int columnBits, string filename) {
    this->numBits = rowBits + columnBits;
    this->numRows = 1 << rowBits;
    this->numColumns = 1 << columnBits;
    populateMap(filename);
}

void WordMap::populateMap(string filename) {
    ifstream file(filename);
    short int counter = 0;

    for (int i = 0; i < this->numRows; i++) {
        for (int j = 0; j < this->numColumns; j++) {
            string temp;
            getline(file, temp);
            if (!temp.empty()) {
                //printf("%s: %d\n", temp.c_str(), counter);
                this->encoding[temp] = counter;
            }
            counter++;
        }
    }

    file.close();
}

int WordMap::lookup(string key) {
    auto search = this->encoding.find(key);
    if (search == this->encoding.end())
        return -3;
    //printf("Lookup %s: %d (%lu)\n", key.c_str(), search->second, this->encoding.count(key));
    return search->second;
}