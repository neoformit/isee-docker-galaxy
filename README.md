# iSEE Docker Galaxy

A dockerized iSEE to run as an interactive tool in Galaxy

---

### The Docker container should:
- Read in an SCE dataset (`test-data/src/sce_mini/`)
- and a templated R script (`test-data/src/isee.R` or `arg[0]`)
- then run that dataset in iSEE

In production Galaxy, the R script should be templated by the Galaxy iSEE tool
based on user input, allowing iSEE parameters to be exposed in the tool form.

[This video](https://www.youtube.com/watch?v=iqqDU2crIEQ&t=1002s&ab_channel=Docker)
is a great resource if you're just getting started with Docker.

---

### Build the container (Ubuntu)

```sh
# N.B you may need to run make as sudo if docker requires sudo for your user

cd <my-dev-directory>
git clone https://github.com/neoformit/isee-docker-galaxy.git && \
cd isee-docker-galaxy && \
sudo apt install -y docker make && \
make
```

---

### Test iSEE

The `test-data` directory contains some data to test run the container:

```
# test-data
# └── src
#     ├── prep.R
#     └── sce_mini
#         ├── assays.h5
#         └── se.rds
```

Run the container on this test data and check out iSEE in your browser:

```sh
make test
```

---

### Take down the container

The docker container will run forever unless you stop it:

```sh
# Run in a new terminal if docker is blocking the current one
make stop

# Once you're done with the container
make clean
```

---

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

If you'd like to streamline the above process, you can update `DOCKERHUB_NAME`
in the `makefile` and build/deploy like this:

```sh
make deploy
```

The remote should now be available for consumption by Galaxy (or anyone else):

```sh
docker pull <account-name>/<repository>
```
