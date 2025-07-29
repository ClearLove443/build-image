FROM docker.all-hands.dev/all-hands-ai/openhands:0.43

# Install necessary packages including OpenJDK, Maven and GitHub CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg \
        openjdk-17-jdk \
        maven && \
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
        apt-get update && \
        apt-get install -y gh && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Print current user information
RUN whoami && id