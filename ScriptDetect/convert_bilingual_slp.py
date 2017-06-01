import re
import string
import subprocess
import detect_sanskrit

def isEnglish(token):
    if (token == '\n'):
        return True
    return detect_sanskrit.detect(token) == 0


with open('slp_ramayana.txt', 'r') as f:
    text = f.read()
regex = re.compile(ur'[%s]+|[\u0900-\u097F]+|\w+|\s' % string.punctuation, re.UNICODE)
with open('dev_ramayana.txt', 'w') as f:
    for token in regex.findall(text.decode('utf-8')):
        if (isEnglish(token)):
            f.write(token.encode('utf-8'))
            continue
        with open("temp.txt", "w") as f2:
            f2.write(token.encode('utf-8'))
        output = subprocess.check_output(['../Transcriber/transcriber', '6', '0', 'temp.txt'])
        f.write(output)