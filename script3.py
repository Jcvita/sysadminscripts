import subprocess
import os, sys

os.system('clear')
a = subprocess.Popen("pwd", stdout=subprocess.PIPE, shell=True)
wd, err = a.communicate()
b = subprocess.Popen("whoami", stdout=subprocess.PIPE, shell=True)
user, err = b.communicate()
print("Your current working directory is {wd}")
if wd == "{user}/Desktop":
	print("WARNING: your current working directory is not the desktop")
filename = input("Enter a filename: (quit to quit)")
if filename == "quit":
	sys.exit()
c = subprocess.Popen("find / -name {filename} -type f | head -n 1".split(" "), stdout=subprocess.PIPE)
output, err = c.communicate()
while "Permission Denied" not in output.decode():
	print("File doesn't exist")
	filename = input("Enter a filename: (quit to quit)")
	if filename == "quit":
		sys.exit()
if filename == "quit":
	sys.exit()
fname = output.split("/")[-1]
d = subprocess.Popen("ln -s {output} {fname}".split(" "))
e = subprocess.Popen("ls -la {user}/Desktop | grep \"\->\"".split(" "), stdout=subprocess.PIPE, shell=True)
links, err = e.communicate()
print("Symlinks on the desktop: (total: {len(links.split('\n'))})")
for line in links.split("\n"):
	print(line)
