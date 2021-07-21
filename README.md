# isee Docker Galaxy

A dockerized iSEE to run as an interactive tool in Galaxy

---

### The Docker container should:
- Read in an SCE dataset (`test-data/src/sce_mini/`)
- and a templated R script (`test-data/src/prep.R`)
- then run that dataset in iSEE

The `prep()` function in `prep.R` can be extended to manipulate the `sce` object before presenting in iSEE. By default this function returns the `sce` object without modification.

The `iSEE_PARAMS` array in `prep.R` can be used to pass arbitrary
arguments to the `iSEE()` function call. Make sure that they are valid params otherwise this will of course break! (in Galaxy, should be validated in the tool form).

---

### Build the container

```sh
cd <my-dev-directory>
git clone https://github.com/neoformit/isee-docker-galaxy.git
cd isee-docker-galaxy
sudo apt install docker
sudo docker build -t isee:test .
```

### Test run

The `test-data` directory contains some data to test run the container:

```sh
# test-data
# └── src
#     ├── prep.R
#     └── sce_mini
#         ├── assays.h5
#         └── se.rds

cd test-data
docker run -v "$(pwd)"/src:/import -p 5000:8888 isee:test
# When output stream stops, app should be available at http://127.0.0.1:5000
```
