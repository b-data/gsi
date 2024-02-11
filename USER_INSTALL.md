# Git source installation (user directory)



## Prerequisites

Ask your system administrator to install the following packages:

### Compile and install

Dependencies for compiling and installing the Git binaries including the
documentation in various formats:

*  `dh-autoreconf`
*  `libcurl4-gnutls-dev`
*  `libexpat1-dev`
*  `gettext`
*  `zlib1g-dev`
*  `libssl-dev`
*  `libpcre2-dev`
*  `asciidoc`
*  `xmlto`
*  `docbook2x`

### Runtime

The latest version of Git (currently 2.43.1) requires the following packages at
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

Export environment variables `GIT_VERSION` and `PREFIX`, e.g.

```bash
mkdir $HOME/.local
export GIT_VERSION=2.43.1 PREFIX=$HOME/.local
```

Compile Git binaries including documentation and install in your `~/.local`
directory:

```bash
curl -sSLO \
    https://github.com/git/git/archive/refs/tags/v$GIT_VERSION.tar.gz \
  && tar -zxf v$GIT_VERSION.tar.gz \
  && cd git-$GIT_VERSION \
  && make configure \
  && ./configure \
    --prefix=$PREFIX \
    --libexecdir=$PREFIX/lib \
  && make all doc info strip \
  && make install install-doc install-html install-info
```
