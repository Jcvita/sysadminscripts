import os
import sys
import subprocess

for csv in [x for x in sys.argv[1:] if x[-4:] == ".csv"]:
    users = [] 
    for line in open(csv, "r").readlines():
        eid, lname, fname, off, phone, dept, grp = line.split(",")
        shell = "/bin/chs" if grp == "office" or grp == "ceo" else "/bin/bash"
        if eid == "EmployeeID":
            continue
        if not (fname.upper().isupper() and lname.upper().isupper()):
            print(f"BAD RECORD: {eid}")
            continue
        if phone.lower().isupper() or phone.lower().islower():
            print(f"BAD RECORD: {eid}")
            continue
        if "" in line.split(","):
            print(f"{eid} not added due to missing records")
            continue
        if not grp == subprocess.run(f"getent group {grp}".split(" "), stdout=subprocess.PIPE, text=True)\
                .stdout.split(":")[0]:
            print(f"groupadd -f {grp}")
            subprocess.run(f"getent group {grp}".split(" "))
        user = fname[:1] + lname
        dupe = str(users.count(user)) if users.count(user) > 0 else ""
        users.append(user)
        user = user + dupe
        #TODO do adduser command
