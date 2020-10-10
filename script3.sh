clear
echo "Your current working directory is $(pwd)"
if [[ $(pwd) != "/home/$(whoami)/Desktop" ]]; then
	echo -e "\e[41mWARNING\e[49m: your current working directory is not the desktop"
fi
echo "Enter a file for the user to create a symlink for. (quit to quit)" 
read input
OUTPUT=$(find / -name $input -type f | head -n 1)
while [$input != "quit" && echo $OUTPUT | grep "Permission denied" ]; do
	echo "file doesn't exist"
	read input
done
if [input != "quit"]; then
	exit 0
fi
FNAME = $(echo $OUTPUT | tr "/" "\n")
ln -s $OUTPUT ${FNAME[-1]}
NUM_LINKS = $(ls -la /home/$(whoami)/desktop | grep "\->")
echo "Number of symlinks on the desktop: $NUM_LINKS"
echo 


