# Materials for #NGSchool2019 - Machine Learning for Biomedicine

You will find here the materials for workshops, hackathons and lectures at the #NGSchool2019, together with installation directions and tips for running the software necessary for participation in the NGSchool2019.

## Table of Content 

  * [General instructions](#general-instructions)
     * [Colab](#colab)
     * [Working on Prometheus](#Working-on-Prometheus)
  * [Talks](#talks)
  * [Workshops](#workshops)
     * [Intro to HPC](#intro-to-hpc)
     * [Intro to R](#intro-to-r)
     * [Intro to Python](#intro-to-python)
     * [Intro to Stats](#intro-to-stats)
     * [Unsupervised learning](#unsupervised-learning)
     * [Bayesian Inference](#bayesian-inference)
     * [Natural language processing](#natural-language-processing)
     * [Reinforcement Learning](#reinforcement-learning)
     * [Deep learning methods for genomics](#deep-learning-methods-for-genomics)
     * [Deep Generative Models for dimensionality reduction](#deep-generative-models-for-dimensionality-reduction)
     * [Tree based methods](#tree-based-methods)
     * [Lasso workshop](#lasso-workshop)
  * [Hackathons](#hackathons)
     * [Dilated Convolutional Neural Nets for DNase-seq and ATAC-seq footprinting](#dilated-convolutional-neural-nets-for-dnase-seq-and-atac-seq-footprinting)


## General instructions

### Colab
[Google Colab](https://colab.research.google.com) is an online service in which you can run jupyter notebooks (and even use some limited GPU!) It comes with some preloaded libraries which makes it easier to teach and run tutorials without having to spend too much time on fixing dependencies etc.

### Working on Prometheus
To access the cluster:

`ssh username@pro.cyfronet.pl`

Clone NGSchool repo:

`git clone https://github.com/NGSchoolEU/ngs19.git`

Inside folders with workshops, that are meant to be run on cluster, there will be *.slurm files with the job description.

To run a job:

`sbatch jobname.slurm`

Job log will be created in the current directory: `jobname-log-JOBID.txt`. 

To check if the job is in the qeue:

`squeue -u $USER`

To cancel the job:

`scancel JOBID`

Majority of the workshops will be run inside notebooks, how to use them with cluster is described here [Intro to HPC](#intro-to-hpc).


## Talks
[Guilliame Fillion - "An experiment on anti-academic research"](talks/ngschool_2019_Filion.pdf)

## Workshops

### Intro to HPC
tutor: Klemens Noga

The wbsite with info about the workshop can be accessed [here](https://docs.cyfronet.pl/display/~plgnoga/NGSchool2019)

### Intro to R
tutor: Maja Kuzman


### Intro to Python
tutor: Kasia Kędzierska

The whole workshop will be executed in the Jupyter notebook, and will rely on several Python packages. In the directory you can find a `setup_check.sh` script you can run to see if your enviorenment satisfies all requirements.

Install and check if requirements are satisfied.

```
bash intro_to_python/setup_check.sh
```

Requirements:
* `python3`  
* `Jupyter` 
* python3 modules:
	* `numpy`
	* `pandas` 
	* `matplotlib`
	* `scipy`


### Intro to Stats
tutor: German Demidov

### Unsupervised learning
tutor: Kasia Kędzierska

Slides: [unsupervised_learning/unsupervised_learning_slides.pdf](unsupervised_learning/unsupervised_learning_slides.pdf)

The workshop will be run in R notebook. We would work locally and the following packages are required.

Requirements:
* `R` 3.5+
* `tidyverse` 1.2.1+
* `factoextra` 1.0.5+
* `ggpubr` 0.2+
* `ggsci`  2.9+
* `MASS` 7.3-50+
* `tsne` 0.1-3+
* `umap` 0.2.3.1+

```
required_packages <- c("tidyverse", "factoextra", "ggpubr", 
                       "ggsci", "MASS", "tsne", "umap")

for (pkg in required_packages) {
  if(!require(pkg, character.only = TRUE, 
              quietly = TRUE, 
              warn.conflicts = FALSE)) {
    print(paste0("Warning! Installing package: ", pkg, "."))
    install.packages(pkg)
  } 
}

print("All done! :)")
```

### Bayesian Inference
tutor: Roman Cheplyaka

Either in RStudio or in the interactive R session run following commands:

```
required_packages <- c("rstan", "StanHeaders", "magrittr", "reshape2", 
                       "forcats", "stringr", "dplyr", "purrr", "readr",
                       "tidyr", "tibble")

for (pkg in required_packages) {
  if(!require(pkg, character.only = TRUE, 
              quietly = TRUE, 
              warn.conflicts = FALSE)) {
    print(paste0("Warning! Installing package: ", pkg, "."))
    install.packages(pkg)
  } 
}

print("All done! :)")
```

### Natural language processing
tutor: Noura Al Moubayed

#### Installation guidelines

1. Install miniconda

Start by installing miniconda.

https://docs.conda.io/en/latest/miniconda.html

2. Create conda environment 

To simplify, we can crete the enviromnet from the yml file: [nlp/workshop.yml](nlp/workshop.yml)

`conda env create -f nlp/workshop.yml`

3. **FROM LOCAL COPY** Install missing package:

a. Copy the file from USB

Due to a large file size (>1GB), we are copying the `en_core_web_lg` from USB sticks distributed on site. When you copy the file from a USB, please change the following command to point to the location of the file.

b. Copy from server

If you **didn't** copy the file from USB stick, copy it from local server.

```
scp <your-user>@10.0.0.200:/srv/en_core_web_lg-2.2.0.tar.gz ~/
```

Now, install it.

```
# python -m spacy download en_core_web_lg
conda activate workshop
pip install /path/to/folder/with/en_core_web_lg-2.2.0.tar.gz
```

4. Clone the repository

Make sure your github repository is up to date and unpack one of files from the nlp directory! The files is gziped to reduce its size.

```
git pull origin master
gunzip nlp/tutorial_features.pkl.gz
```

#### Running the workshop

```
cd nlp
conda activate workshop
jupyter notebook
```

### Reinforcement Learning
tutor: Robert Loftin

In order to run locally:

```
conda create --name reinforced python=3.7
conda activate reinforced
pip install numpy==1.17.3
pip install gym==0.15.3
pip install matplotlib==3.0.3
#pip install torch==1.3.0
conda install pytorch torchvision cpuonly -c pytorch
pip install chainer
pip install minerl
pip install opencv-python-headless
pip install roboschool
conda install jupyter
conda install -c anaconda openjdk
jupyter-notebook
```

### Deep learning methods for genomics
tutor: Ron Schwessinger

[Slides](./deep_learning/slides_deep_learning_methods_for_genomics.pdf)

The seminar hands-on workshop will be run in a [google colab notebook](https://colab.research.google.com/drive/1SRHe_SXmKeXImNBR6tnhFQ3eThM4-iZu). A google account is required though. Additional information can be found in this [repo](https://github.com/rschwess/tutorial_dl_for_genomics) but no need to install anything for the workshop.

### Deep Generative Models for dimensionality reduction
tutor: Kaspar Märtens

### Tree based methods
tutor: Rosa Karlic

You will work locally in RStudio, execute following code to install packages:

```
required_packages <- c("caret", "rpart", "e1071", 
                       "ranger", "dplyr", "randomForest", "rpart.plot",
		       "ipred", "bst", "plyr")

for (pkg in required_packages) {
  if(!require(pkg, character.only = TRUE, 
              quietly = TRUE, 
              warn.conflicts = FALSE)) {
    print(paste0("Warning! Installing package: ", pkg, "."))
    install.packages(pkg)
  } 
}

print("All done! :)")
```

### Lasso workshop
tutor: Tim Padvitski

You will work locally in RStudio, execute following code to install packages:

```
required_packages <- c("c060", "glmnet", "igraph)

for (pkg in required_packages) {
  if(!require(pkg, character.only = TRUE, 
              quietly = TRUE, 
              warn.conflicts = FALSE)) {
    print(paste0("Warning! Installing package: ", pkg, "."))
    install.packages(pkg)
  } 
}

print("All done! :)")
```

## Hackathons

### Dilated Convolutional Neural Nets for DNase-seq and ATAC-seq footprinting 
Requirements: 
* `python3`
* `keras` and `Tensorflow v1.14` as backend
* `numpy`
* `scikit-learn`
* google account for colab notebook work

Literature:
* [Dnase Footprinting general Introduction](https://www.nature.com/articles/nmeth.3768)
* [Learning genomic signals at base pair resolution](https://drive.google.com/file/d/1kg6Ic0-FvJtVUva9Mh3FPnOAHJcN6VB-/view)


### 
