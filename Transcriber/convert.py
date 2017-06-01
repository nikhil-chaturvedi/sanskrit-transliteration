import os

def convert(filename): 
	f1 = open( filename + '.txt', 'rb')
	f2 = open( filename + '2.txt', 'wb')
	while 1:
		byte = f1.read(1)
		if not byte:
			break
		if (ord(byte) == 164 or ord(byte) == 165):
			byte = chr(ord(byte)+2)
		f2.write(byte)
	f1.close()
	f2.close()
	os.remove( filename + '.txt' )
	os.rename( filename + '2.txt', filename + '.txt' )


filelist = ['swar', 'maatra', 'vyanjan', 'number']
for filename in filelist:
	convert(filename)