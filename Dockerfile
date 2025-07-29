FROM docker.all-hands.dev/all-hands-ai/openhands:0.43

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-17-jdk \
        maven && \
        gh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN whoami && id