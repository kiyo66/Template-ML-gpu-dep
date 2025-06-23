ARG TREE_INSTALL_IMG=rust:1.82
ARG BASE_IMAGE=nvidia/cuda:12.6.2-cudnn-devel-ubuntu24.04

FROM ${TREE_INSTALL_IMG} AS tree-builder

RUN apt-get update && apt-get install -y  --no-install-recommends pkg-config libssl-dev curl git
RUN cargo install tree-sitter-cli --version 0.25.0
RUN cargo install stylua --version 0.2.0

FROM ${BASE_IMAGE} AS dep

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV DEBCONF_NOWARNINGS=yes

ARG USER_NAME
ARG GROUP_NAME
ARG NUM_UID
ARG NUM_GID
ARG PYTHON_VERSION=3.12.0
ARG PYTHON_MODULE_VERSION=3.12

# ===============================================
# Install Packages
# ===============================================
RUN apt-get update && \
    : "Basic tools" && \
    apt-get install -y -qq --no-install-recommends curl xsel sudo wget fish git tar unzip && \
    apt-get install -y -qq --no-install-recommends make build-essential ninja-build zlib1g-dev libssl-dev libreadline-dev libffi-dev libgdbm-dev libdb-dev uuid-dev dpkg-dev gnupg libc6-dev libpng-dev libjpeg-dev libtiff-dev libfreetype6-dev libx11-dev libxext-dev libxrender-dev libgl1-mesa-dev libharfbuzz-dev libfribidi-dev tk-dev && \
    : "Vim" && \
    apt-get install -y -qq --no-install-recommends luarocks ripgrep && \
    : "Japanese packages" && \
    apt-get install -y -qq --no-install-recommends locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    : "Python" && \
    cd /usr/local/src && \
    wget --no-check-certificate https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar -Jxvf Python-${PYTHON_VERSION}.tar.xz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --with-ensurepip && make && make install && \
    apt-get install -y -qq --no-install-recommends python${PYTHON_MODULE_VERSION}-tk python${PYTHON_MODULE_VERSION}-dev python${PYTHON_MODULE_VERSION}-venv && \
    python3 -m pip install --upgrade pip setuptools wheel && \
    : "Post process" && \
    rm -rf /var/lib/apt/lists/* && apt-get autoremove -y -qq

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja_JP
ENV LC_ALL ja_JP.UTF-8
ENV TZ=Asia/Tokyo

COPY --from=tree-builder /usr/local/cargo/bin/tree-sitter /usr/local/bin/tree-sitter
COPY --from=tree-builder /usr/local/cargo/bin/stylua /usr/local/bin/stylua

COPY requirements.txt /env/
RUN pip3 install -r /env/requirements.txt
# matplotlib
RUN git clone https://github.com/matplotlib/matplotlib.git
RUN cd matplotlib && git checkout v3.9.0 && pip3 install .
RUN pip3 install --force-reinstall torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

# Adding password-less user
RUN userdel ubuntu && \
groupadd -g ${NUM_GID} ${GROUP_NAME} && \
useradd -s /usr/bin/fish -u ${NUM_UID} -g ${NUM_GID} -m ${USER_NAME} && \
usermod -G sudo ${USER_NAME} && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}/workspace
ENTRYPOINT [ "/bin/bash", "/env/scripts/entrypoint.sh" ]

