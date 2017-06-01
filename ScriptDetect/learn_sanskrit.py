from bs4 import BeautifulSoup
import string
import subprocess
import pickle
import os
import re

regex = re.compile('\d')

bayesFeatures = {}
bayesComplete = {}
bayesTotal = [0, 0]

def tokenize(html):
    soup = BeautifulSoup(html)
    for script in soup(["script", "style"]):
        script.extract()
    remove_punct_map = dict((ord(char), u' ') for char in string.punctuation)
    text = soup.get_text().translate(remove_punct_map)
    return filter(None, text.split())

def isInvalid(token):
    if ((not  token) or token is None or token == ''):
        return True
    if (len(token) <= 1):
        return True
    return regex.search(token)

def isAscii(token):
    try:
        token.decode('ascii')
    except:
        return False
    else:
        return True

def tokenizeSanskrit(html):
    tokens = []
    for token in tokenize(html):
        with open("temp.txt", "w") as f:
            f.write(token.encode('utf-8'))
        output = subprocess.check_output(['../Transcriber/transcriber', '0', '6', 'temp.txt'])
        tokens.append(output)
    return tokens

def populateDict(tokens, lang):
    for token in tokens:
        if (not isAscii(token)):
            continue
        if (isInvalid(token)):
            continue
        if (not bayesComplete.has_key(token)):
            bayesComplete[token] = [0, 0]
        bayesComplete[token][lang] += 1
        for i in range(0, len(token)):
            for j in range(i+2, min(i+6, len(token)+1)):
                substr = token[i:j]
                if (not bayesFeatures.has_key(substr)):
                    bayesFeatures[substr] = [0, 0]
                bayesFeatures[substr][lang] += 1
        bayesTotal[lang] += 1

print "sa"
for file in os.listdir("sa"):
    print "sa" + "/" + file
    with open("sa" + "/" + file, 'r') as f:
        html = f.read()
    populateDict(tokenizeSanskrit(html), 1)

print "en"
for file in os.listdir("en"):
    print "en" + "/" + file
    with open("en" + "/" + file, 'r') as f:
        html = f.read()
    populateDict(tokenize(html), 0)

with open('en-vel-substr-total.pkl', 'wb') as f:
    pickle.dump(bayesTotal, f, pickle.HIGHEST_PROTOCOL)
with open('en-vel-substr.pkl', 'wb') as f:
    pickle.dump(bayesFeatures, f, pickle.HIGHEST_PROTOCOL)
with open('en-vel-complete.pkl', 'wb') as f:
    pickle.dump(bayesComplete, f, pickle.HIGHEST_PROTOCOL)