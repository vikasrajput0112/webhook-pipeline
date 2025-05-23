# Use an official lightweight Ubuntu image as base
FROM ubuntu:22.04

# Disable prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential tools
RUN apt-get update && \
    apt-get install -y \
    git \
    wget \
    curl \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Keep container running by default (so exec commands work)
CMD ["tail", "-f", "/dev/null"]
