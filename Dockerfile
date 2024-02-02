# Use a minimal Alpine Linux image as the base
FROM alpine:latest

# Set the working directory
WORKDIR /home/nick

# Install base dependencies
RUN apk --update --no-cache add \
    build-base \
    curl \
    gcc \
    git \
    musl-dev

# Create a new user
RUN locale-gen en_US.UTF-8 && \
    adduser --quiet --disabled-password --shell /bin/zsh --home /home/nick --gecos "User" nick && \
    echo "nick:p@ssword1" | chpasswd &&  usermod -aG sudo nick

# Some basic development tools
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
    sbcl \
    rust \

# Custom configuration
RUN git clone https:/github.com/nshan651/dwm.git \
    git clone https://github.com/nshan651/dwmblocks.git \
    git clone https://github.com/nshan651/st.git \
    git clone https://github.com/nshan651/dotfiles.git

# Clean up package cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Entry point
CMD ["/bin/zsh"]
