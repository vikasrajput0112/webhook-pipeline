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

# Default command
CMD ["bash"]
---

# Use Ubuntu as base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y git wget curl ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Default command to run when the container starts
CMD ["bash"]
