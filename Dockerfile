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
    ncurses \
    openssl \
    tzdata

# Set locale
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Set the desired timezone
ENV TZ=America/Chicago

# Install your shell of choice
RUN $INSTALL bash zsh

# Deps for st and dwm
RUN $INSTALL libx11-dev \
	     libxft-dev \
             harfbuzz-dev \
	     # Additional dep for dwm
	     libxinerama-dev 

# Ensure the following programs are built from source in .local/opt

# st is a nice and simple terminal emulator
RUN git clone https://github.com/nshan651/st.git .local/opt/st && \
    cd .local/opt/st && \
    make && make install

# Install dwm for a cozy window manager environment
RUN git clone https://github.com/nshan651/dwm.git .local/opt/dwm && \
    cd .local/opt/dwm && \
    make && make install

# dwmblocks for useful status blocks
RUN git clone https://github.com/nshan651/dwmblocks.git .local/opt/dwmblocks && \
    cd .local/opt/dwmblocks && \
    make && make install

# dmenu is an excellent file selector
RUN $INSTALL dmenu

# Keybinding manager
RUN $INSTALL sxhkd

# Emacs or Vim? Why not both? :D
RUN $INSTALL emacs neovim

# Web browser
RUN $INSTALL firefox

# Office suite
RUN $INSTALL libreoffice

# File managers
RUN $INSTALL lf pcmanfm

# Image viewer
RUN $INSTALL sxiv

# PDF tools
RUN $INSTALL pandoc zathura

# RSS feed reader
RUN $INSTALL newsboat

# Some basic development tools
RUN $INSTALL \
    bc \
    fzf \
    gdb \
    jq \
    ripgrep \
    # rsync needed for dotfiles
    rsync \ 
    tmux \
    tmuxinator \
    valgrind

# Add a non-root user
RUN adduser -D -u 1000 porto
USER porto

# Pull down dotfiles
RUN git clone https://github.com/nshan651/dotfiles.git .config/dotfiles && \
    cd .config/dotfiles && \
    # Install scripts to .local/bin, config files to .config
    make

# Clean up package cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Entry point
CMD ["/bin/zsh"]
