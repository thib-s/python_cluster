cd nosave/env_parallel
source bin/activate
for i in `cat /proc/cpuinfo | awk '/^processor/{print $3}'`;
do
   screen -dmS "engine$i" ipengine ~/.ipython/profile_default/security/ipcontroller-engine.json
done
