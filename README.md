# Home Assistant OS image builder for Khadas Devices
## Building image on Linux system
Following instructions are tested on Debian/Ubuntu system. But you should be able to adapt them for other Linux distributions as well.
### Install required packages

```bash
$ sudo apt-get install git bash sudo docker.io curl file
```

### Clone Fenix repository

```bash
$ mkdir -p ~/project/khadas
$ cd ~/project/khadas
$ git clone --depth 1 --recursive https://github.com/khadas/haos-builder
$ cd haos-builder
```

### Build image

```bash
$ scripts/enter.sh make <target>
```
For example, to build for VIM3L

```bash
$ scripts/enter.sh make khadas_vim3l
```

List of supported targets can be seen by running

```bash
$ scripts/enter.sh make help
```

## Build in Docker (Recommended for Windows/macOS)

### Get Docker image

```bash
$ docker pull docker/dind
```

### Create container instance

```bash
$ docker run -it --name haos-builder --privileged \
             docker/dind /bin/sh
```

### Install required packages within container instance

```bash
/ # apk add git bash sudo curl file
```

### Get the source code

```bash
/ # git clone --depth 1 --recursive https://github.com/khadas/haos-builder
/ # cd haos-builder
```

### Build image

```bash
/ # scripts/enter.sh make <target>
```

For example, to build for VIM3L

```bash
$ scripts/enter.sh make khadas_vim3l
```

List of supported targets can be seen by running

```bash
$ scripts/enter.sh make help
```
