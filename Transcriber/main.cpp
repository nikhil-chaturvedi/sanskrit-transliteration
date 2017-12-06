#undef yyFlexLexer
#define yyFlexLexer DevFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer SlpFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer BenFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer GurFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer GujFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer OriFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer TelFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer VelFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer ItrFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer HarFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer IsoFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer IasFlexLexer
#include <FlexLexer.h>

#undef yyFlexLexer
#define yyFlexLexer IpaFlexLexer
#include <FlexLexer.h>

#include <vector>
#include <fstream>
#include <sstream>
#include "Resources/Decode.h"
#include "Devanagiri/DevDecode.h"
#include "SLP1/SlpDecode.h"
#include "Bengali/BenDecode.h"
#include "Gurmukhi/GurDecode.h"
#include "Gujarati/GujDecode.h"
#include "Oriya/OriDecode.h"
#include "Telugu/TelDecode.h"
#include "Velthius/VelDecode.h"
#include "ITRANS/ItrDecode.h"
#include "HarvardKyoto/HarDecode.h"
#include "ISO15919/IsoDecode.h"
#include "IAST/IasDecode.h"
#include "IPA/IpaDecode.h"

using namespace std;

FlexLexer* getLexer(int script, istream* infile) {
    switch (script) {
        case 0: return new DevFlexLexer(infile);
        case 1: return new BenFlexLexer(infile);
        case 2: return new GurFlexLexer(infile);
        case 3: return new GujFlexLexer(infile);
        case 4: return new OriFlexLexer(infile);
        case 5: return new TelFlexLexer(infile);
        case 6: return new SlpFlexLexer(infile);
        case 7: return new VelFlexLexer(infile);
        case 8: return new ItrFlexLexer(infile);
        case 9: return new HarFlexLexer(infile);
        case 10: return new IsoFlexLexer(infile);
        case 11: return new IasFlexLexer(infile);
        case 12: return new IpaFlexLexer(infile);
        default: return NULL;
    }
}

Decode* getDecoder(int script) {
    switch (script) {
        case 0: return new DevDecode;
        case 1: return new BenDecode;
        case 2: return new GurDecode;
        case 3: return new GujDecode;
        case 4: return new OriDecode;
        case 5: return new TelDecode;
        case 6: return new SlpDecode;
        case 7: return new VelDecode;
        case 8: return new ItrDecode;
        case 9: return new HarDecode;
        case 10: return new IsoDecode;
        case 11: return new IasDecode;
        case 12: return new IpaDecode;
        default: return NULL;
    }
}

int main( int argc, char** argv)
{
    int encodingScript = atoi(argv[1]);
    FlexLexer* lexer;
    ifstream infile;
    if (argc >  4) {
        infile.open(argv[3]);
        lexer = getLexer(encodingScript, &infile);
    } else {
        stringstream ss;
        ss.str(argv[3]);
        //infile.open(argv[3]);
        //lexer = getLexer(encodingScript, &infile);
        lexer = getLexer(encodingScript, &ss);
    }

    short int temp;
    vector<short int> encoding;
    while((temp = (short int)lexer->yylex()) != -1) {
        if (temp == -2) {
            encoding.push_back(-1);
            continue;
        }
        else if (temp == -3)
            continue;
        //printf("%04x ", temp);
        encoding.push_back(temp);
    }
    //printf("\n");
    //if (argc > 4)
        infile.close();

    if (argc > 4) {
        ofstream outfile(argv[4]);
        int decodingScript = atoi(argv[2]);
        Decode* decoder = getDecoder(decodingScript);

        for (short int code : encoding) {
            if (code == -1) {
                outfile << "\n";
                continue;
            }
            outfile << decoder->decode(code);
        }
        outfile.close();
    } else {
        int decodingScript = atoi(argv[2]);
        Decode* decoder = getDecoder(decodingScript);
        for (short int code : encoding) {
            printf("%s", decoder->decode(code).c_str());
        }
        std::cout << std::endl;
    }

    return 0;
}