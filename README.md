# JenkinsProject


### Jenkins Project:

Build a Jenkins master with nodes and run a groovy pipeline script that does the following:

We have 3 types of scripts which written in three different script languages:

[C script](https://github.com/kamalaweenat/jenkins-project/blob/3b802fcc72c03338a16908dc8743d98180e63d37/scripts/sum.c) <br>
[Python script](https://github.com/kamalaweenat/jenkins-project/blob/3b802fcc72c03338a16908dc8743d98180e63d37/scripts/sum.py) <br>
[Bash script](https://github.com/kamalaweenat/jenkins-project/blob/3b802fcc72c03338a16908dc8743d98180e63d37/scripts/sum.sh) <br>

The [groovy script](https://github.com/kamalaweenat/jenkins-project/blob/3b802fcc72c03338a16908dc8743d98180e63d37/Jenkinsfile) will run the desired script in the pipeline - stages and show these results

**Clone Sources** (from github) -> **Building** -> **Running the script** (c, python, bash) -> **Result** (with cleaning the env.) 

The script source code for each one of the C, Python, Shell exists on the GitHub,

If Jenkins notices any changes on the GitHub it immediately runs the pipeline (this is done by identifying cron job every minute)
Another option is to run the pipeline manually..

