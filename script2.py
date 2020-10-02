import sys
import subprocess
import time

for csv in [x for x in sys.argv[1:] if x[-4:] == ".csv"]:
    users = []
    for line in open(csv, "r").readlines():
        eid, lname, fname, off, phone, dept, grp = line.split(",")[:7]
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
        if not grp == subprocess.run(f"getent group {grp}".split(" "), stdout=subprocess.PIPE, text=True) \
                .stdout.split(":")[0]:
            print(f"groupadd -f {grp}")
            subprocess.run(f"getent group {grp}".split(" "))
        user = fname[:1] + lname.replace("'", "")
        user = user.lower()
        dupe = str(users.count(user)) if users.count(user) > 0 else ""
        users.append(user)
        user = user + dupe
        subprocess.run(["useradd", "-m", "-d", f"/home/{grp}/{user}", "-s", shell, "-g", grp, "-c",
                        f"\"{fname} {lname}\"", user])
        print(f"useradd -m -d /home/{grp}/{user} -s {shell} -g {grp} -c \"{fname} {lname}\" {user}")
        # TODO run passwd with stdin
        p = subprocess.Popen(f"passwd --stdin {user}".split(" "), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        p.stdin.write(user[::-1].encode())
        p.stdin.flush()
        print(p.stdout)
        time.sleep(.001)
        e = subprocess.run(f"passwd -e {user}".split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(e.stdout)
