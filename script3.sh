clear
echo "Your current working directory is $(pwd)"
if [[ $(pwd) != "/home/$(whoami)/Desktop" ]]; then
	echo -e "\e[41mWARNING\e[49m: your current working directory is not the desktop"
fi
echo "Enter a file for the user to create a symlink for. (quit to quit)" 
read input
while [input != "quit" && find -type f ]; do
	

done
