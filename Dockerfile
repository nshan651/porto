# Use a minimal Alpine Linux image as the base
FROM alpine:latest

# Set the working directory
WORKDIR /home/dev

# Install basic dependencies 
RUN apk --update --no-cache add \
    build-base \
    gcc \
    git \
    musl-dev

# Install basic development tools
RUN apk --update --no-cache add \
    zsh \
    bash \
    neovim \
    emacs \
    tmux \
    lf \
    ripgrep

# Install programming languages
RUN apk --update --no-cache add \
    python \
    common-lisp \
    rust
    tmux

# Custom configuration
# I personally use DWM for a comfy window management experience
RUN git clone https:/github.com/nshan651/dwm.git \
    git clone https://github.com/nshan651/dwmblocks.git \
    git clone https://github.com/nshan651/st.git \
    git clone https://github.com/nshan651/dotfiles.git
 

# Clean up package cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Entry point for the container
CMD ["/bin/sh"]
