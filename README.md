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

Installation:
=============

A install script is comming soon, but for now, the install is made manually...

Prior installation you must have:
 - screen
 - ssh access to all nodes
 - shared home dir (this is not mandatory but you will have to copy the engine json configuration file)

To install you must:
 1. install python an pyenv. In this env you must install:
    - jupyter notebook
    - all ipyparallel dependencies
    - some dependencies may have been forgotten, if so, let me know !
 2. add an environnement variable CLUSTER\_ENV\_LOC leading to the root of your environnement
 3. clone this git repo on the node

note: these steps can be run in the shared directory or in you can repeat this operation on each node

finally to start the cluster, you may run the start\_cluster.sh, for more info: start\_cluster.sh --help
