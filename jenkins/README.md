# Jenkins

This is a simple Jenkinsfile that will allow to build and deploy the docker container present on docker folder.
Jenkinsfile contains four stages:

- *Prepare:* Checkout the code from SCM (github, bitbucket or any other used)
- *Build Docker Image:* Build the docker image using the code downloaded from the repo. Also, grype and dive have been added to the image, to ensure that the image complies in terms of security and we're not wasting space on the docker image
- *Deploy:* Deploys the statefulset using the new image
- *Notify*: Added as a placeholder, for notifying 3rd party systems (bitbucket, slack, teams or any other...)

## Git flow
Using this pipeline the proposal for the git flow will be the following:

- Feature branches used per each developer. This branches will be deployed in dev environment
- Develop branch, in which feature branches are merged. This branch will be considered stable enough, so it will be deployed on dev/stg environments
- Production branch. Production ready code that will be deployed into production branch
- Hotfix. In case that a hotfix is needed in prod, code from prod branch will be used. Then we'll merge that hotfix using a PR into prod and develop branches