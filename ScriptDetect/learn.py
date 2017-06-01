from bs4 import BeautifulSoup
import string
import pickle
import re
import os

regex = re.compile('\d')

bayesFeatures = {}
bayesComplete = {}
bayesTotal = [0, 0, 0]

def tokenize(html):
    soup = BeautifulSoup(html)
    for script in soup(["script", "style"]):
        script.extract()
    remove_punct_map = dict((ord(char), u' ') for char in string.punctuation)
    text = soup.get_text().translate(remove_punct_map)
    return filter(None, text.split())

def isAscii(token):
    try:
        token.decode('ascii')
    except:
        return False
    else:
        return True

def isInvalid(token):
    return regex.search(token)

def getLang(dir):
    return {
        'en': 0,
        'de': 1,
        'es': 2,
    }[dir]


def populateDict(tokens, lang):
    for token in tokens:
        if (not isAscii(token)):
            continue
        if (isInvalid(token)):
            continue
        token = token.lower()
        if (not bayesComplete.has_key(token)):
            bayesComplete[token] = [0, 0, 0]
        bayesComplete[token][lang] += 1
        for i in range(0, len(token)):
            for j in range(i+1, min(i+7, len(token)+1)):
                substr = token[i:j]
                if (not bayesFeatures.has_key(substr)):
                    bayesFeatures[substr] = [0, 0, 0]
                bayesFeatures[substr][lang] += 1
        bayesTotal[lang] += 1


dirs = ['en', 'de', 'es']
for dir in dirs:
    print dir
    lang = getLang(dir)
    for file in os.listdir(dir):
        #print dir + "/" + file
        with open(dir + "/" + file, 'r') as f:
            html = f.read()
        populateDict(tokenize(html), lang)

with open('total.pkl', 'wb') as f:
    pickle.dump(bayesTotal, f, pickle.HIGHEST_PROTOCOL)
with open('bayes.pkl', 'wb') as f:
    pickle.dump(bayesFeatures, f, pickle.HIGHEST_PROTOCOL)
with open('complete.pkl', 'wb') as f:
    pickle.dump(bayesComplete, f, pickle.HIGHEST_PROTOCOL)