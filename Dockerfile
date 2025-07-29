FROM registry.cn-hangzhou.aliyuncs.com/onlyyounotothers/runtime:0.43-nikolaik

# Step 1: Update package list and install base packages (gnupg is needed for gpg)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg \
        openjdk-17-jdk \
        maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Step 2: Add GitHub CLI's GPG key and repository
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Step 3: Update package list (again) and install gh
RUN apt-get update && \
    apt-get install -y gh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 验证 gh 命令是否可用
RUN gh --version

# 验证 java 命令是否可用
RUN java -version

# 验证 mvn 命令是否可用
RUN mvn -version

# Print current user information
RUN whoami && id