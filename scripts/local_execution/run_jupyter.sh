source $CLUSTER_ENV_LOC/bin/activate

screen -dmS "jupyter_master" jupyter-notebook --no-browser
