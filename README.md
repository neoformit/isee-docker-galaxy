# isee Docker Galaxy

A dockerized iSEE to run as an interactive tool in Galaxy

---

### The Docker container should:
- Read in an SCE dataset (`test-data/src/sce_mini/`)
- and a templated R script (`test-data/src/prep.R`)
- then run that dataset in iSEE

The `prep()` function in `prep.R` can be extended to manipulate the `sce`
object before presenting in iSEE. By default this function returns the `sce`
object without modification. This probably won't be implemented unless a use
case can be demonstrated (e.g. filter the data before display).

The `iSEE_PARAMS` array in `prep.R` can be used to pass arbitrary
arguments to the `iSEE()` function call. Make sure that they are valid params
otherwise iSEE will of course raise an error (in the Galaxy tool, arguments
should be passed through a validation script). It's probably worth trying to
pass exception messages back to the user as this is a likely source of failure.

[This video](https://www.youtube.com/watch?v=iqqDU2crIEQ&t=1002s&ab_channel=Docker)
is a great resource if you're just getting started with Docker.

---

### Build the container

> To deploy to Galaxy, make sure you `git checkout` and build the `main` branch.
For running locally in the `test-data` directory, checkout the `local-testing`
branch.

```sh
cd <my-dev-directory>
git clone https://github.com/neoformit/isee-docker-galaxy.git && \
cd isee-docker-galaxy && \
sudo apt install -y docker && \
# N.B you may need to run docker with sudo \
docker build -t isee:test ./docker
```

### Test run

> To test locally, build the `local-testing` branch

The `test-data` directory contains some data to test run the container:

```sh
# test-data
# └── src
#     ├── prep.R
#     └── sce_mini
#         ├── assays.h5
#         └── se.rds

cd test-data
docker run -d -v "$(pwd)"/src:/import -p 5000:8888 --name isee isee:test
```

Give the app 20 seconds to fire up, then find it at http://127.0.0.1:5000 in
your browser. If you're having trouble connecting, try `docker run` without
detached mode `-d` to view output as iSEE starts up.

### Take down the container

The docker container will run forever unless you stop it:

```sh
docker container stop isee
```

### Push the container

Here we push the container to a Docker Hub repository, but you could push it
to any other container registry by changing `account-name` to a web address
e.g. `quay.io/account/repository`. You will need to authenticate your local
docker with `docker login` using an access token before you can interact with a
remote repository. You can obtain an access token in your container registry
account.

```sh
# Build deploy image
docker build -t isee:galaxy ./docker
# Tag image with remote reference
docker tag isee:galaxy <account-name>/<repository>
# Push the image to the remote
docker push <account-name>/<repository>
```

The remote should now be available for consumption by Galaxy (or anyone):

```sh
docker pull <account-name>/<repository>
```
