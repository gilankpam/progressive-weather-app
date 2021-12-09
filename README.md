# [Progressive Weather App](https://jimmerioles.github.io/progressive-weather-app/)
Original Readme

## New Added Feature

### Containerization

It uses Docker to containerized the application. On Dockerfile there are 3 stages, base, testrunner and main.
Testrunner stage used to run unit test. We used the same dockerfile with same base image to run the unit test to make sure the full compatibility with the build image. To run the test, first we need to build and specify the target to `testrunner`. 

```
docker build -t app-test --target=testrunner .
docker run --rm app-test
```

The main stage it uses nginx to act as static web server. The nginx config is located on `deploy/nginx.conf`.

### Makefile

Makefile uses to simplify the process. There are 4 processes.

* Test = run unit test

* Build = build into docker image

* Push = push to docker registry

* Deploy = upgrade kubernetes release using helm

### Helm Chart

Helm used to package the application to be easily deployed to kubernetes cluster. With helm we can easily version and manage releases. Helm also support to deploy multiple release of the same app in the same cluster or namespace for case like staging release, canary etc.

### Azure Pipeline

Azure pipeline help automate the CICD process. Every push will run the automated unit test (make test), and every tag with prefix `release-*` will be deployed. Deployment flow:

* Create new tag from any branch you want to deploy

```
git tag release-v1
git push origin release-v1
```

* Azure pipeline will automatically trigger build and deploy