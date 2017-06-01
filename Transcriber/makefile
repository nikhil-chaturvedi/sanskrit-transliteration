CC = g++ -w
EXE = transcriber

LANGS = \
    Devanagiri:Dev \
    Bengali:Ben \
    Gurmukhi:Gur \
    Gujarati:Guj \
    Oriya:Ori \
    Telugu:Tel \
    SLP1:Slp \
    Velthius:Vel \
    ITRANS:Itr \
    HarvardKyoto:Har \
    ISO15919:Iso \
    IAST:Ias \
    IPA:Ipa

all:
	$(foreach lang, $(LANGS), \
		$(eval longname = $(word 1,$(subst :, ,$(lang)))) \
		$(eval shortname = $(word 2,$(subst :, ,$(lang)))) \
		\
		flex $(longname)/transcribe.l; \
		mv lex.$(shortname).cc $(longname)/lex.$(shortname).cc; \
	)
	$(CC) main.cpp Resources/CodeMap.cpp Resources/WordMap.cpp $(foreach lang, $(LANGS), \
		$(eval longname = $(word 1,$(subst :, ,$(lang)))) \
		$(eval shortname = $(word 2,$(subst :, ,$(lang)))) \
		\
		$(longname)/$(shortname)Decode.cpp $(longname)/$(shortname)Encode.cpp $(longname)/lex.$(shortname).cc \
	) -o $(EXE)
	