# Use a minimal Alpine Linux image as the base
FROM alpine:latest

# Set custom args
ARG USERNAME=porto \
    INSTALL="apk --update --no-cache add"

# Set the working directory
WORKDIR /home/$USERNAME

# Install base dependencies
RUN $INSTALL \
    build-base \
    curl \
    gcc \
    git \
    musl-dev \
    musl-locales \
    openssl \
    tzdata

# Set locale
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Set the desired timezone
ENV TZ=America/Chicago

# st is a nice and simple terminal emulator
RUN git clone https://github.com/nshan651/st.git \
    cd st && \
    make && make install

RUN $INSTALL bash zsh

# Install dwm for a cozy window manager environment
RUN git clone https:/github.com/nshan651/dwm.git && \
    cd dwm && \
    make && make install

# dwmblocks for useful status blocks
RUN git clone https://github.com/nshan651/dwmblocks.git \
    cd dwmblocks && \
    make && make install

# dmenu is an excellent file selector
RUN $INSTALL dmenu

RUN $INSTALL sxhkd

# Emacs or Vim? Why not both? :D
RUN $INSTALL emacs neovim

RUN $INSTALL firefox

RUN $INSTALL libreoffice

RUN $INSTALL lf pcmanfm

RUN $INSTALL sxiv

RUN $INSTALL pandoc zathura

RUN $INSTALL newsboat

# Some basic development tools
RUN $INSTALL \
    bc \
    fzf \
    gdb \
    jq \
    ripgrep \
    tmux \
    tmuxinator \
    valgrind

# Set up a non-root user
# RUN useradd -m -s /bin/zsh porto
    # echo "porto ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/porto
# Add a non-root user
RUN adduser -D -u 1000 porto
USER porto

# Clean up package cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Remove dotfiles
# TODO

# Entry point
CMD ["/bin/zsh"]
