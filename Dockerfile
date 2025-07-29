FROM registry.cn-hangzhou.aliyuncs.com/onlyyounotothers/runtime:0.43-nikolaik

# Install necessary packages including OpenJDK, Maven, gnupg, then setup and install GitHub CLI
# Step 1: Update package list and install base packages (gnupg is needed for gpg)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg \
        openjdk-17-jdk \
        maven && \
    # Clean up apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Step 2: Add GitHub CLI's GPG key and repository
# This is a separate RUN command to leverage Docker layer caching
# If the repository setup changes, only this layer needs to be rebuilt
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Step 3: Update package list (again) and install gh
# Since we added a new repository, we need to run apt-get update
RUN apt-get update && \
    apt-get install -y gh && \
    # Clean up again
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Print current user information
RUN whoami && id