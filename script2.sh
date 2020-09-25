for csv in "$@"
do

	if [ -r $csv ]; then
		while IFS=, read -r eid lname fname off phone dept grp
		do
			if [ $eid == "EmployeeID" ]; then continue; fi
			user="${fname:0:1}$lname"
			user="${user,,}" 
			
			if [[ $lname =~ [0-9] || $fname =~ [0-9] || $phone =~ [a-zA-Z] ]]; then
				echo "BAD RECORD: $eid"
				continue
			fi
			if [ -z $eid || -z $lname || -z $fname || -z $off || -z $phone || -z $dept || -z $grp ]; then
				echo "User account $user not added due to missing information."
				continue
			fi
			if [[ ! "$(getent group $grp)" == *"$grp"* ]]; then
				echo "groupadd -f $grp"
				groupadd -f $grp
			fi	
			if [[ "$grp" == "office" || "$grp" == "ceo" ]]; then
				shell=$("/bin/csh")
			else
				shell=$("/bin/bash")
			fi
			
		done < $csv
	
	else
		echo "File $csv doesn't exist"
	fi
done

