FROM ubuntu:24.04

ARG TARGETARCH

# ---------- Locale & base packages ----------
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    sudo locales tzdata ca-certificates build-essential cmake unzip wget curl \
    git zsh fzf ripgrep fd-find jq \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# ---------- GitHub CLI ----------
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# ---------- Starship ----------
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# ---------- Zellij ----------
RUN ZELLIJ_VERSION="0.41.2" && \
    if [ "$TARGETARCH" = "arm64" ]; then \
        ZELLIJ_ARCH="aarch64"; \
    else \
        ZELLIJ_ARCH="x86_64"; \
    fi && \
    curl -fsSL "https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-${ZELLIJ_ARCH}-unknown-linux-musl.tar.gz" \
    | tar xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/zellij

# ---------- Neovim (0.10+) ----------
RUN NVIM_VERSION="0.10.4" && \
    if [ "$TARGETARCH" = "arm64" ]; then \
        NVIM_ARCH="arm64"; \
    else \
        NVIM_ARCH="x86_64"; \
    fi && \
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" \
    | tar xz -C /opt && \
    ln -sf /opt/nvim-linux-${NVIM_ARCH}/bin/nvim /usr/local/bin/nvim

# ---------- Non-root user ----------
RUN useradd -m -s /bin/zsh -G sudo dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/dev

# ---------- Copy dotfiles & run install ----------
COPY --chown=dev:dev . /home/dev/.dotfiles

USER dev
WORKDIR /home/dev

ENV DOTFILES_NONINTERACTIVE=1
RUN cd /home/dev/.dotfiles && bash install.sh

# ---------- NVM + Node ----------
ENV NVM_DIR=/home/dev/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install --lts

# ---------- Pre-install Neovim plugins ----------
RUN nvim --headless "+Lazy! sync" +qa || true
RUN nvim --headless "+TSUpdateSync" +qa || true

ENTRYPOINT ["/bin/zsh", "-l"]
