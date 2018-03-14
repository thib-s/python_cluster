cd nosave/env_parallel
source bin/activate

ipcontroller --ip="*" &
jupyter-notebook --no-browser
