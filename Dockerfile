# Dockerfile
FROM ubuntu:22.04

# Install necessary packages including OpenSSH Server
RUN apt-get update && apt-get install -y \
    vim \
    nano \
    git \
    lsof \
    procps \
    wget \
    curl \
    sqlite3 \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install Java
RUN mkdir -p /opt && \
    wget https://download.oracle.com/java/22/archive/jdk-22.0.2_linux-aarch64_bin.tar.gz -O /tmp/openjdk.tar.gz && \
    tar -xzf /tmp/openjdk.tar.gz -C /opt && \
    rm /tmp/openjdk.tar.gz

# Set environment variables for Java
ENV JAVA_HOME="/opt/jdk-22.0.2"
ENV PATH="$JAVA_HOME/bin:$PATH"

# Configure SSH
RUN mkdir /var/run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Copy the setup script into the container
COPY keys/setup-ssh.sh /usr/local/bin/setup-ssh.sh

# Make the script executable
RUN chmod +x /usr/local/bin/setup-ssh.sh

# Expose SSH port
EXPOSE 22

# Create a unique directory and file in each container

# Start SSH service and keep the container running
CMD ["/bin/bash", "-c", "/usr/local/bin/setup-ssh.sh && /usr/sbin/sshd -D"]
