import urllib
import sys

lang = sys.argv[1]
num = int(sys.argv[2])
for i in range (1, num+1):
    urllib.urlretrieve("http://" + lang + ".wikipedia.org/wiki/Special:Random", lang + "/" + str(i) + ".html")