from bs4 import BeautifulSoup
import string
import pickle
import math
import operator
import re

regex = re.compile('\d')

with open('bayes.pkl', 'rb') as f:
    bayesFeatures = pickle.load(f)
with open('complete.pkl', 'rb') as f:
    bayesComplete = pickle.load(f)
with open('total.pkl', 'rb') as f:
    bayesTotal = pickle.load(f)

def calcProb(num, den):
    return math.log(num + 1) - math.log(den + 2)

def bayesProb(substr, lang):
    if (not bayesFeatures.has_key(substr)):
        return calcProb(0, bayesTotal[lang])
    return calcProb(bayesFeatures[substr][lang], bayesTotal[lang])

def posterior(lang):
    return math.log(bayesTotal[lang]) - math.log(sum(bayesTotal))

def getLang(lang):
    return {
        0: 'en',
        1: 'de',
        2: 'es',
    }[lang]

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
    if (len(token) == 1):
        return True
    return regex.search(token)

def predict(prediction):
    maxIndex, _ = max(enumerate(prediction), key=operator.itemgetter(1))
    #print str(prediction) + " : " + getLang(maxIndex)
    return maxIndex

def completePredict(token):
    if (not bayesComplete.has_key(token)):
        return -1
    maxIndex, maxVal = max(enumerate(bayesComplete[token]), key=operator.itemgetter(1))
    if (maxVal < 500):
        return -1
    if (maxVal < 0.75 * sum(bayesComplete[token])):
        return -1
    return maxIndex

def detect(token):
    token = token.lower()
    #if (token == 'side'):
    #    print bayesComplete[token]
    completePred = completePredict(token)
    if (completePred <> -1):
        return completePred
    prediction = [0.0, 0.0, 0.0]
    for i in range(0, len(token)-1):
        for j in range(i + 2, min(i + 7, len(token) + 1)):
            substr = token[i:j]
            for k in range(0, 3):
                prediction[k] += bayesProb(substr, k)
    for k in range(0, 3):
        prediction[k] += posterior(k)
    return predict(prediction)

def detectFile(file):
    with open(file, 'rb') as f:
        tokens = tokenize(f.read())
    predictions = [0, 0, 0]
    for token in tokens:
        if (not isAscii(token)):
            continue
        if (isInvalid(token)):
            continue
        pred = detect(token)
        predictions[pred] += 1
        if (pred <> 2):
            print token + " : " + str(pred)
    print predictions

detectFile('test2.htm')