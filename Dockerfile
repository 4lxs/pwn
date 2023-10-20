FROM phusion/baseimage:jammy-1.0.1

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 \
  && apt -y update && apt install -y \
    libstdc++6:i386 \
    bsdmainutils \
    qemu \
    strace \
    ltrace \
    tmux \
    neovim \
    gdb \
    gdb-multiarch \
    build-essential \
    git \
    libffi-dev \
    libssl-dev \
    python3 \
    python3-dev \
    python3-pip
  # && rm -rf /var/lib/apt/list/*

RUN python3 -m pip install -U pip && \
  python3 -m pip install --no-cache-dir \
  ipython \
  angr \
  pwntools \
  ropper

RUN git clone --depth 1 https://github.com/pwndbg/pwndbg && \
cd pwndbg && chmod +x setup.sh && ./setup.sh

# # nightly neovim
# RUN apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip git binutils wget
# RUN git clone https://github.com/neovim/neovim.git /tmp/neovim && \
#   cd /tmp/neovim && \
#   git fetch --all --tags -f && \
#   git checkout ${TARGET} && \
#   make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local/ && \
#   make install && \
#   strip /usr/local/bin/nvim
#
#
# # copy nvim config
# COPY .nvim /root/.config/nvim
# RUN nvim --headless "+Lazy! sync" +"sleep 15" +qa \
# && nvim --headless "+MasonToolsInstall" +"sleep 20" +qa


WORKDIR /ctf

CMD [ "tmux" ]
