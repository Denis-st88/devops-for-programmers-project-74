### Hexlet tests, push test and linter status:
[![Actions Status](https://github.com/Denis-st88/devops-for-programmers-project-74/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Denis-st88/devops-for-programmers-project-74/actions/workflows/hexlet-check.yml)
[![Actions Status](https://github.com/Denis-st88/devops-for-programmers-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/Denis-st88/devops-for-programmers-project-74/actions/workflows/push.yml)


## Requirements:

* Docker Compose >= 1.27.0


## Run project locally:

```
make prepare-env
make dev
# open https://localhost
```


## Production

### Build image:

```
make build-prod
```

### Run tests:

```
make test
```

### Push image:

```
make push
```

### Pull image:
```
docker pull denis88dev/devops-for-programmers-project-74:latest
```

## Links
[Dockerhub image](https://hub.docker.com/repository/docker/denis88dev/devops-for-programmers-project-74/general)
