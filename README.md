# Git source-install

[![minimal-readme compliant](https://img.shields.io/badge/readme%20style-minimal-brightgreen.svg)](https://github.com/RichardLitt/standard-readme/blob/master/example-readmes/minimal-readme.md) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

## Table of Contents

*  [Install](#install)
*  [Usage](#usage)
*  [Contributing](#contributing)
*  [License](#license)

## Install

```
curl -sSL https://gitlab.com/b-data/git/gsi/-/archive/master/gsi-master.tar.gz \
  -o gsi.tar.gz

tar -zxf gsi.tar.gz --one-top-level --strip-components=1
```

## Usage

```bash
for file in sample.*; do cp "$file" "${file#sample.}"; done;

docker-compose up --build -V
```

## Contributing

PRs accepted.

This project follows the
[Contributor Covenant](https://www.contributor-covenant.org)
[Code of Conduct](CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE) © 2021 b-data GmbH
