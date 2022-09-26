[![minimal-readme compliant](https://img.shields.io/badge/readme%20style-minimal-brightgreen.svg)](https://github.com/RichardLitt/standard-readme/blob/master/example-readmes/minimal-readme.md) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) <a href="https://liberapay.com/benz0li/donate"><img src="https://liberapay.com/assets/widgets/donate.svg" alt="Donate using Liberapay" height="20"></a> <a href="https://benz0li.b-data.io/donate?project=4"><img src="https://benz0li.b-data.io/donate/static/donate-with-fosspay.png" alt="Donate with fosspay"></a>

# Containerised Git source-installation

[This project](https://gitlab.com/b-data/git/gsi) is intended for system
administrators who want to perform a source-installation of
[Git](https://github.com/git/git). It is meant for installing
[tagged Git releases](https://github.com/git/git/tags) on Debian-based
Linux distributions, e.g. Ubuntu, using a docker container.

To perform a source-installation of Git in your own home directory, see
[USER_INSTALL.md](USER_INSTALL.md)

## Table of Contents

*  [Prerequisites](#prerequisites)
*  [Install](#install)
*  [Usage](#usage)
*  [Contributing](#contributing)
*  [License](#license)

## Prerequisites

This projects requires an installation of docker and docker compose.

### Docker

To install docker, follow the instructions for your platform:

*  [Install Docker Engine | Docker Documentation > Supported platforms](https://docs.docker.com/engine/install/#supported-platforms)
*  [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)

### Docker Compose

*  [Install Docker Compose](https://docs.docker.com/compose/install/)

### Debian Packages

The latest version of Git (currently 2.37.3) requires the following packages at
runtime:

*  `libc6`
*  `libcurl3-gnutls`
*  `liberror-perl`
*  `libexpat1`
*  `libpcre2-8-0`
*  `perl`
*  `zlib1g`

These packages, as well as `tar` and `curl`, must be available on the host.

## Install

Download and extract the source code of this project:

```bash
curl -sSL https://gitlab.com/b-data/git/gsi/-/archive/main/gsi-main.tar.gz \
  -o gsi.tar.gz

tar -zxf gsi.tar.gz --one-top-level --strip-components=1
```

## Usage

Change directory and make a copy of all `sample.` files:

```bash
cd gsi

for file in sample.*; do cp "$file" "${file#sample.}"; done;
```

Set `IMAGE` according to the host's Debian-based Linux distribution
(`<distribution>:<release>`), `GIT_VERSION` to the desired version of Git
(`<major>.<minor>.<patch>`) and `PREFIX` to the location, where you want the
git programs to be installed (default: `/usr/local`).

Then, create and start container _gsi_ using options `--build` (_Build images
before starting containers_) and `-V` (_Recreate anonymous volumes instead of
retrieving data from the previous containers_):

```bash
docker-compose up --build -V
```

Do not forget to add `PREFIX[/SUBDIR]/bin` to `PATH` when using a `PREFIX`
within `/opt`.

## Contributing

PRs accepted.

This project follows the
[Contributor Covenant](https://www.contributor-covenant.org)
[Code of Conduct](CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE) © 2021 b-data GmbH
