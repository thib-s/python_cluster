cd nosave/env_parallel
source bin/activate

pcontroller --ip="*" &
jupyter-notebook --no-browser
