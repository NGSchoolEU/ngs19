#!/bin/bash
#SBATCH --partition plgrid
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 4
#SBATCH --time 04:00:00
#SBATCH --job-name nlm-tunnel
#SBATCH --output nlm-log-%J.txt
#SBATCH --mem 4G
#SBATCH --account ngschool2019

## workshop info
software_dir="$PLG_GROUPS_SHARED/plggngschool/software"
 
## get tunneling info
XDG_RUNTIME_DIR=""
ipnport=$(shuf -i8000-9999 -n1)
ipnip=$(hostname -i)
user=$USER
 
## print tunneling instructions to jupyter-log-{jobid}.txt
echo -e "
    Copy/Paste this in your local terminal to ssh tunnel with remote
    -----------------------------------------------------------------
    ssh -N -L $ipnport:$ipnip:$ipnport ${user}@pro.cyfronet.pl
    -----------------------------------------------------------------
 
    Then open a browser on your local machine to the following address
    ------------------------------------------------------------------
    localhost:$ipnport  (prefix w/ https:// if using password)
    ------------------------------------------------------------------
    "
 
source "$software_dir/non_linear_models/non_linear_models.rc"

## start an ipcluster instance and launch jupyter server
jupyter-lab --no-browser --port=$ipnport --ip=$ipnip
