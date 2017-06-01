//
// Created by Nikhil Chaturvedi on 17/03/17.
//

#include "CodeMap.h"
#include <fstream>

CodeMap::CodeMap(int rowBits, int columnBits, string filename) {
    this->numBits = rowBits + columnBits;
    this->numRows = 1 << rowBits;
    this->numColumns = 1 << columnBits;
    populateMap(filename);
}

void CodeMap::populateMap(string filename) {
    ifstream file(filename);
    short int counter = 0;

    for (int i = 0; i < this->numRows; i++) {
        for (int j = 0; j < this->numColumns; j++) {
            string temp;
            getline(file, temp);
            if (!temp.empty()) {
                //printf("%s: %d\n", temp.c_str(), counter);
                string temp2(temp);
                this->decoding[counter] = temp2;
            }
            counter++;
        }
    }

    file.close();
}

string CodeMap::lookup(short int key) {
    auto search = this->decoding.find(key);
    if (search == this->decoding.end())
        return "";
    //printf("Lookup %d: %s (%lu)\n", key, search->second.c_str(), this->decoding.count(key));
    return search->second;
}