source `cat ~/.cluster_env_loc`/bin/activate
for i in `cat /proc/cpuinfo | awk '/^processor/{print $3}'`;
do
   screen -dmS "engine$i" ipengine ~/.ipython/profile_default/security/ipcontroller-engine.json
done
