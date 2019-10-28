## Prometheus Quick Start Guide for NGSchool2019

On the Prometheus cluster we do not work on the login node. To start your work
you need to reserve the resources on the computing nodes using SLURM. The
following document will guide you for the process specific to the NGSchool2019
workshops and hackathons.

More general references:
*  [Klemens Noga's Quick tutorial](https://docs.cyfronet.pl/display/~plgnoga/NGSchool2019)
*  [Prometheus Basics Guide:](https://kdm.cyfronet.pl/portal/Prometheus:Basics)

### Reserving the resources to work on the cluster in jupyter-lab interactive mode

The SLURM `sbatch` scripts has been added to this repository and reside in the
directories dedicated to the particular workshops. After loading they will
reserve the resources for your session, set the path to the R library directory
and activate the appropriate Python virtual environment.


**The example setup for your work would be:**


If you do not have the repository cloned in your `$HOME` directory clone it
to receive the files:
```sh
cd ~
git clone https://github.com/NGSchoolEU/ngs19.git
```


I you do have it pull all the recent changes:
```sh
cd ~/ngs19
git pull
```


To reserve the resources and run the jupyter session you need to pass 
the appropriate configuration file to `sbatch`. To do this for example for
the Deep Learning workshop:
```sh
sbatch ngs19/deep_learning.slurm
```

Remember to activate the jupyter-lab in the directory where you want to start
your work.


After this wait a while until your submitted job is processed by the system.


Next proceed exactly how it was described by Klemens Noga during his
introductory workshop and summarized in [his guide](https://docs.cyfronet.pl/display/~plgnoga/Python+Jupyter+notebooks)


This schedules your work in the interactive jupyter session for **4 hour by
default**. Please **save your intermediate work** before this time runs out or your
results will be lost! Alternatively you can rise the time limit set in the
configuration file.


**After finishing remember to free the resources by cancelling your job!**
To view all your submitted jobs run:
```sh
squeue -u $USER
```
To cancel your running job run:
```sh
scancel -j <job-id>
```
TO cancel all your jobs run:
```sh
scancel -u $USER
```

### Reserving the resources to work on the cluster in interactive shell session

To work on the cluster in the interactive shell session run this example
command:
```sh
srun --mem=4G --time=02:00:00 -p plgrid-now -N 1 --ntasks-per-node=1 -n 1 -A ngschool2019 --pty /bin/bash -l
```

This reserves single CPU/task on a single node with 4GB of RAM for 2 hours,
using our current grant resources from the ngschool2019 grant.


Next you need to source the configuration file for your particular workshop to
activate the virtual environment and load all the required environmental
variables.


For example for the Deep Learning workshop you have to:
```sh
source "$PLG_GROUPS_SHARED/plggngschool/software/deep_learning/deep_learning.rc"
```

Now you can run R or Python interactive shell with all the modules or libraries
available for your project.

---

### Software installation and directory structure

#### Directory structure

The configuration files, R user library, CUDA proprietary library and Python
virtual environments reside in the directory:

```sh
$PLG_GROUPS_SHARED/plggngschool/software
```

Users from the `plggngs_adm` group have read/write privileges for this
directory.


The directory structure is as follows:
```
software/
├── cuda
│   ├── include
│   ├── lib64
│   └── NVIDIA_SLA_cuDNN_Support.txt
├── deep_learning
│   ├── deep_learning
│   ├── deep_learning.rc
│   └── requirements.txt
├── nlp
│   ├── nlp
│   ├── nlp.rc
│   └── requirements.txt
├── non_linear_models
│   ├── non_linear_models
│   ├── non_linear_models.rc
│   └── requirements.txt
├── R
│   ├── library
│   ├── Renviron.ngschool
│   └── Rprofile.ngschool
├── reinforcement_learning
│   ├── reinforcement_learning
│   ├── reinforcement_learning.rc
│   └── requirements.txt
└── unsupervised_learning
    ├── requirements.txt
    ├── unsupervised_learning
    └── unsupervised_learning.rc
```


*  The `*.rc` files contain configuration for each workshop.
*  The `cuda` directory contains the proprietary NVIDIA cuDNN library required
   for TensorFlow GPU computing.
*  The R directory contains the `Renviron.ngschool` file which point the R installation to
   the `R/library` folder containing all of the locally installed package.
   Additionally it points to the `Rprofile.ngschool` file which sets
   the R option `bitmapType="cairo"` which tells the `png` graphical device not
   to use the X11 for plotting.
*  Each of the workshop folders contain similarly named folder with Python
   virtual environment and the required modules.
*  `requirements.txt` files contain Python pip module requirements.

#### Software instalation

Users from the `plggngs_adm` group which contains the organizers and hackathon
mentors can install Python modules with pip and R packages after sourcing their
appropriate `*rc` file. The packages and modules installed in this way will be
available for all the users of their workshop. For example:

```sh
source $PLG_GROUPS_SHARED/plggngschool/software/deep_learning.rc
pip install seaborn
```

You can also do the same from within the jupyter-lab/jupyter-notebook terminal,
without the need of sourcing the configuration file. The same is possible with
jupyter shell magic, like:

```
!pip install seaborn
```

***Important for TensorFlow and R users***

By default R module loads cuda==9.0, and TensorFlow depends on cuda==10.0. When
doing GPU computing with R and then switching to TensorFlow run:
```sh
module swap plgrid/apps/cuda/10.0
```

Similarly after doing GPU computing in TensorFlow and wanting to do the same in
R run:
```sh
module swap plgrid/apps/cuda/9.0
```

#### Example configuration files

```sh
# software/deep_learning/deep_learning.rc
export LD_LIBRARY_PATH="$PLG_GROUPS_SHARED/plggngschool/software/cuda/lib64:$LD_LIBRARY_PATH"
module load plgrid/apps/r/3.6.0
module load plgrid/libs/tensorflow-gpu/1.13.1-python-3.6
source "$PLG_GROUPS_SHARED/plggngschool/software/deep_learning/deep_learning/bin/activate"
source "$PLG_GROUPS_SHARED/plggngschool/software/R/Renviron.ngschool"
```


```sh
# software/deep_learning/requirements.txt
argparse
h5py
keras
numpy
pandas
pybigwig
pysam
rpy2
jupyterlab
#tensorflow >=1.8,<=1.14
```


```sh
# software/R/Renviron.ngschool 
export R_LIBS_USER="$PLG_GROUPS_SHARED/plggngschool/software/R/library"
export R_PROFILE="$PLG_GROUPS_SHARED/plggngschool/software/R/Rprofile.ngschool"
```

 
```sh
# software/R/Rprofile.ngschool 
options(bitmapType = 'cairo')
```
---

