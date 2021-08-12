# SENG440-Final-Project
TODO: Project reason and description, how to run it

To test the code on the remote physical arm machine:
ssh netlink@seng440.ece.uvic.ca
cd /tmp/team-9/SENG440-Final-Project
git checkout whatever-branch
arm-linux-gcc -static -o MatrixInversion.exe MatrixInversion.c
lftp user1@arm
    password: q6coHjd7P
put MatrixInversion.exe
put matrixFile.txt
telnet arm
    creds: user1, q6coHjd7P
chmod +e MatrixInversion.exe
./MatrixInversion.exe matrixFile.txt