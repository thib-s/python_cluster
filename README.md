Architecture:
=============

on master: juptyter + ipcontroller
on nodes: ipengine

all programs run in a different screen session for persistence

Folders:
========

scripts:
--------

Contains script to launch everything on each node.

local\_execution contains scripts to run locally on the master/slaves nodes

remote\_execution contains scripts to automate the run of master/slaves script remotely via ssh. It must be used as follow:
./myscript username hostname

Which will run the commmand inside the script on the hostname via ssh.

or:

./xargs\_cmd.sh hostnames\_file.txt "./myscript username"

Which will run myscript on all node specified in hostnames\_file.txt.

notebooks:
----------

Contains the notebooks for testing and exploiting ipyparallel power !
