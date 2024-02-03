# Use a minimal Alpine Linux image as the base
FROM alpine:latest

# Set the working directory
WORKDIR /home/cabin

# Install base dependencies
RUN apk --update --no-cache add \
    build-base \
    curl \
    gcc \
    git \
    musl-dev

# Some basic development tools
RUN apk --update --no-cache add \
    zsh \
    bash \
    neovim \
    emacs \
    tmux \
    lf \
    ripgrep

# Clean up package cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Remove dotfiles
# TODO

# Entry point
CMD ["/bin/zsh"]
