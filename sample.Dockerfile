ARG IMAGE

FROM $IMAGE

ARG DEBIAN_FRONTEND=noninteractive

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

CMD ["start.sh"]
