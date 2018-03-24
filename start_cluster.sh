#!/usr/bin/env bash

PROG_NAME="ipyparallel cluster starter"

# Let errors be thrown
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Define common variables for dir, file, hw_root ...
# TODO: test if those variables are still correctly defined when script is executed using 'source'
declare -r DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -r FILE="${DIR}/$(basename "${BASH_SOURCE[0]}")"
declare -r BASE="$(basename ${FILE} .sh)"
declare -r ROOT="$(cd "$(dirname "${DIR}")" && pwd)" # <-- change this as it depends on your app
declare -r -i TIMESTAMP=`date +%s`

usage() {
  cat <<EOF

usage: $PROG_NAME remote_username master_hostname slave_hostname_file

This program start a ipyparallel cluster using ssh connection. It assumes that the setup is already done on each machine of the cluster.

OPTIONS:
  -r	--remote_username	the username used to ssh to each node (currently it's the same for all nodes)
  -m	--master_hostname	the hostname/ip of the master, where the jupyter notebook will be run
  -s	--slave_hostname_file	the file containing the hostnames/ips of each slave (1 hostname per line)
  -p	--remote_project_loc	the location of the project directory on the remote node (the folder with the git root)

the script will perform ssh to all the node, you must exchange ssh key prior running this script, in order to avoid typing repeatedly you password ;)

EOF
}

start_ipcontroller() {
  remote_username="$1"
  master_hostname="$2"
  project_loc="$3"
  echo "starting ipcontroller on $master_hostname ..."

  ssh $remote_username@$master_hostname $project_loc/scripts/local_execution/run_ipcontroller.sh
}

start_jupyter() {
  remote_username="$1"
  master_hostname="$2"
  project_loc="$3"
  echo "starting jupyter on $master_hostname ..."

  ssh $remote_username@$master_hostname $project_loc/scripts/local_execution/run_jupyter.sh
}

start_slaves() {
  remote_username="$1"
  project_loc="$2"
  slave_hostname_file="$3"

  while read -r -u3 HOST;do
    echo "starting engines on $HOST ..."
    bash -c "ssh $remote_username@$HOST $project_loc/scripts/local_execution/run_client.sh"
  done 3< $slave_hostname_file

}

main() {

  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  for i in "$@"; do
  PARAM=`echo "$i" | awk -F= '{print $1}'`
  VALUE=`echo "$i" | awk -F= '{print $2}'`
  case "$PARAM" in
    -h | --help)
      usage
      exit
      ;;
    -r | --remote_username)
      REMOTE_USERNAME="$VALUE"
      ;;
    -m | --master_hostname)
      MASTER_HOSTNAME="$VALUE"
      ;;
    -s | --slave_hostname_file)
      SLAVE_HOSTNAME_FILE="$VALUE"
      ;;
    -p | --remote_project_loc)
      PROJECT_LOC="$VALUE"
      ;;
    --) # No more options left.
      shift
      break
      ;;
    *)
      echo "ERROR: unknown parameter \"$PARAM\""
      usage
      exit 1
      ;;
  esac
  shift
  done

  start_ipcontroller "$REMOTE_USERNAME" "$MASTER_HOSTNAME" "$PROJECT_LOC" 
  start_jupyter "$REMOTE_USERNAME" "$MASTER_HOSTNAME" "$PROJECT_LOC"
  start_slaves "$REMOTE_USERNAME" "$PROJECT_LOC" "$SLAVE_HOSTNAME_FILE"

}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

# Use shunit2 to unit test your bash scripts -> yes, you can !!!
# source /usr/bin/shunit2
