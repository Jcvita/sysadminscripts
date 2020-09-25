
for csv in "$@"
do

	if [ -r $csv ]; then
		while IFS=, read -r eid lname fname off phone dept grp ovrflow
		do
			if [ $eid == "EmployeeID" ]; then
				continue
			fi
			if [ ! $ovrflow == "" ]; then
				continue 
			getent group $grp || echo "groupadd -f $grp"
			getent group $grp || groupadd -f $grp
			
			
			echo "$ovrflow"
		done < $csv
	
	else
		echo "File $csv doesn't exist"
	fi
done

