#!/bin/bash
declare -A ipcounts
ipcounts=()
if [[ -f $1 ]]; then
	echo "Count,IP,Location"	
	while read line; do
		for word in $line; do
			#TODO check if line contains password without printing it
			if echo "$line" | grep "password" && [[ $word =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
				if [[ ${!ipcounts[@]} =~ "$word" ]]; then
					ipcounts[$word]=$(expr "${ipcounts[$word]}" + 1)
				else
					ipcounts[$word]=1
				fi
			fi
		done
		passattempt=false
	done < $1
	for ip in "${!ipcounts[@]}"; do
		if (( ipcounts[$ip] > 10 )); then
			location="$(geoiplookup $ip)"
			echo "${ipcounts[$ip]}, $ip, ${location:28}"
		fi
	done | sort -rn -k1 
else
	echo "Cannot open file: $1"
	exit 1
fi
