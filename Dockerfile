FROM ubuntu:latest

ENV LLVM_VERSION=17
ENV GCC_VERSION=11

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get -y update && apt install -y --fix-missing \
    libc6:i386 libc6-dbg:i386 libc6-dbg lib32stdc++6 g++-multilib cmake ipython3 \
    vim net-tools iputils-ping libffi-dev libssl-dev python3-dev python3-pip \
    build-essential ruby ruby-dev tmux strace ltrace nasm wget gdb gdb-multiarch \
    netcat socat git patchelf gawk file python3-distutils bison rpm2cpio cpio zstd \
    zsh neovim automake flex libglib2.0-dev libpixman-1-dev python3-setuptools cargo \
    libgtk-3-dev ninja-build curl

RUN python3 -m pip install -U pip && \
    python3 -m pip install --no-cache-dir \
    ropgadget z3-solver smmap2 apscheduler ropper unicorn keystone-engine \
    capstone angr pebble r2pipe pwntools jupyter notebook

RUN gem install one_gadget seccomp-tools \
    && rm -rf /var/lib/gems/2.*/cache/*

RUN apt-get install -y lsb-release software-properties-common

RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/radareorg/radare2 ~/radare2 && ~/radare2/sys/install.sh

RUN git clone --depth 1 https://github.com/pwndbg/pwndbg && \
    cd pwndbg && chmod +x setup.sh && ./setup.sh

RUN git clone --depth 1 https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && \
    cd ~/Pwngdb && mv .gdbinit .gdbinit-pwngdb && \
    sed -i "s?source ~/peda/peda.py?# source ~/peda/peda.py?g" .gdbinit-pwngdb && \
    echo "source ~/Pwngdb/.gdbinit-pwngdb" >> ~/.gdbinit

RUN wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py

RUN git clone --depth 1 https://github.com/niklasb/libc-database.git libc-database && \
    cd libc-database && ./get ubuntu debian || echo "/libc-database/" > ~/.libcdb_path && \
    rm -rf /tmp/*

RUN git clone https://github.com/AFLplusplus/AFLplusplus ~/AFLplusplus && cd ~/AFLplusplus && make distrib && make install

ENV LLVM_CONFIG=llvm-config-${LLVM_VERSION}
ENV AFL_SKIP_CPUFREQ=1
ENV AFL_TRY_AFFINITY=1
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1

WORKDIR /ctf/work
COPY .tmux.conf /root/.tmux.conf

CMD "jupyter" "notebook" "--ip" "0.0.0.0" "--port" "8888" "--no-browser" "--allow-root" "--NotebookApp.token='letmein'" "--NotebookApp.password='letmein'"
