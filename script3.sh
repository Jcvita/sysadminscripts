clear
echo "Your current working directory is $(pwd)"
if [[ $(pwd) != "/home/$(whoami)/Desktop" ]]; then
	echo -e "\e[41mWARNING\e[49m: your current working directory is not the desktop"
fi
read input
while [input != "quit"]; do
	

done
