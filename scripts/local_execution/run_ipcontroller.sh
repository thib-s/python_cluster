cd $CLUSTER_ENV_LOC
source bin/activate

screen -dmS "ipcontroller" ipcontroller --ip="*"
