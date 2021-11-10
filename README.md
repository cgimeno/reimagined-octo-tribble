# reimagined-octo-tribble
This repo contains the following folders:

- docker: Contains a Dockerfile which allows to build litecoin.0.18.1
- statefulset/litecoin: Contains a helm chart that allows to deploy the docker container as an statefulset
- jenkins: Contains a Jenkinsfile for building the docker container. Also, it allows to deploy the statefulset using helm
- terraform: Contains a terraform module for creating a new role which can be assumed by all the users on a given account
