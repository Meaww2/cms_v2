# syntax=docker/dockerfile:1
FROM ubuntu:20.04

RUN sed -i -e 's|http://archive.ubuntu.com/ubuntu/|http://mirror.kku.ac.th/ubuntu/|g' /etc/apt/sources.list

RUN apt update
RUN apt upgrade -y
RUN apt install -y tzdata
RUN apt install -y \
    sudo \
    build-essential \
    # openjdk-17-jdk-headless \
    postgresql \
    postgresql-client \
    python3.8 \
    cppreference-doc-en-html \
    cgroup-lite \
    libcap-dev \
    zip \
    python3.8-dev \
    libpq-dev \
    libcups2-dev \
    libyaml-dev \
    libffi-dev \
    python3-pip \
    libcap-dev \
    libcups2-dev \
    libffi-dev \
    libpq-dev \
    libyaml-dev \
    openssh-server \
    screen \
    nano


# RUN apt install -y \
#     build-essential \
#     cgroup-lite \
#     cppreference-doc-en-html \
#     fp-compiler \
#     git \
#     haskell-platform \
#     libcap-dev \
#     libcups2-dev \
#     libffi-dev \
#     libpq-dev \
#     libyaml-dev \
#     mono-mcs \
#     openjdk-8-jdk-headless \
#     php7.4-cli \
#     postgresql-client \
#     python2 \
#     python3-pip \
#     python3.8 \
#     python3.8-dev \
#     rustc \
#     sudo \
#     wait-for-it \
#     zip

# Create cmsuser user with sudo privileges
RUN useradd -ms /bin/bash cmsuser && \
    usermod -aG sudo cmsuser
# Disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# Set cmsuser as default user
USER cmsuser

RUN mkdir /home/cmsuser/cms
COPY --chown=cmsuser:cmsuser requirements.txt dev-requirements.txt /home/cmsuser/cms/

WORKDIR /home/cmsuser/cms

RUN sudo pip3 install -r requirements.txt

COPY --chown=cmsuser:cmsuser . /home/cmsuser/cms


RUN sudo python3 prerequisites.py --yes --cmsuser=cmsuser install
RUN sudo python3 setup.py install

RUN ./database_init.sh

# RUN sudo sed 's|/cmsuser:your_password_here@localhost:5432/cmsdb"|/postgres@cms_test_db:5432/cmsdbfortesting"|' ./config/cms.conf.sample \
#     | sudo tee /usr/local/etc/cms-testdb.conf

ENV LANG C.UTF-8

# ENTRYPOINT ["./CMU_scripts/startAllMain.sh"]

CMD ["tail", "-f", "/dev/null"]

