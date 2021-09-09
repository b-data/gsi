ARG IMAGE

FROM $IMAGE as builder

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_VERSION
ARG PREFIX=/usr/local

ARG USE_LIBPCRE=1
ARG NO_SVN_TESTS=1
ARG NO_PERL_CPAN_FALLBACKS=1
ARG NO_TCLTK=1
ARG NO_INSTALL_HARDLINKS=1
ARG GIT_SKIP_TESTS=t9020
ARG DEFAULT_TEST_TARGET=prove

ARG DESTDIR=/tmp/src

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    sudo \
    # Minimal dependencies for compiling and installing the Git binaries
    dh-autoreconf \
    libcurl4-gnutls-dev \
    libexpat1-dev \
    gettext \
    zlib1g-dev \
    libssl-dev \
    libpcre2-dev \
    make \
    # Additional dependencies to add the documentation in various formats
    asciidoc \
    xmlto \
    docbook2x \
    # On a Debian-based distribution you also need the install-info package
    install-info \
    # Supplemental dependencies for testing CVS and mail interoperability
    apache2 \
    gnupg \
    liberror-perl \
    ## CVS
    cvsps \
    libdbd-sqlite3-perl \
    ## mail
    libmailtools-perl

RUN useradd -ms /bin/bash builder \
  && usermod -aG sudo builder \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder
WORKDIR /home/builder

COPY scripts/git-prompt /var/tmp/
COPY scripts/*.sh /usr/bin/

RUN mkdir -p /tmp/var/cache/gsi \
  && ln -s /etc /tmp/etc \
  && mkdir -p /tmp/usr/local \
  && ln -s /usr/local/share /tmp/usr/local/share \
  && start.sh

FROM $IMAGE

COPY --from=builder /usr/local /usr/local
COPY --from=builder /etc/bash_completion.d /etc/bash_completion.d
