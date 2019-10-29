## Welcome to Cell Of Origin Hackathon!

German Demidov, Maja Kuzman  


## The Groups:  

Group1: Green group http://bit.ly/COOdataG1  
Group2: Red group http://bit.ly/COOdataG2  
Group3: Dark Magenta group http://bit.ly/COOdataG3   


## The Goals:  

### Day 1:  
1. Explain the data set   
2. Explore the data   
    - Explore the response data set  
    - Explore the predictors data set  

### Day 2:  

3. Predict mutational patterns using random forest regression   
    - Find important features  
4. Predict mutational patterns using different methods   
5 . Use mutational profiles to predict cancer type   
6. Try to beat Rosa!  

### Day 3:  

7. Complete the presentations  
8. Good luck!  



### To work on the prometheus:  
This will open an interactive session with 

```
srun --mem=4G --time=02:00:00 -p plgrid-now -N 1 --ntasks-per-node=6 -n 1 -A ngschool2019 --pty /bin/bash -l
module load plgrid/apps/r/3.6.0
source "$PLG_GROUPS_SHARED/plggngschool/software/R/Renviron.ngschool"

```
