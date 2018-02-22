filepath=hardware/$2.txt;
if test -e "$filepath";then
   echo "dump file already exist, skipping..."
else
   echo "dumping hardware info from $2 to file $2.txt..."
   ssh $1@$2 '
   cat /proc/cpuinfo;
   cat /proc/meminfo
   ' >> hardware/$2.txt
   echo "hardware info saved!" 
   sleep 10
fi
