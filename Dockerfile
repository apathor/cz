FROM debian:stable

WORKDIR /root

# install some packages
RUN apt-get update \
    && apt-get install -y \
    locales \
    fzf fzy pick \
    gawk git sed ripgrep jq curl \
    apparix isoquery figlet boxes \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# install cz
COPY bin/cz /usr/bin/cz
RUN chmod +x /usr/bin/cz

# install bash configuration
COPY conf/cz.bashrc ./.bashrc
COPY conf/cz.bash_profile ./.bash_profile

# grab cz repository
RUN git clone https://github.com/apathor/cz.git src

ENTRYPOINT /bin/bash -l
