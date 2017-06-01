from bs4 import BeautifulSoup

with open('test.htm', 'rb') as f:
    soup = BeautifulSoup(f.read())
for script in soup(["script", "style"]):
	script.extract()
print(soup.get_text())