# Jenkins agent image with all tools pre-installed
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y curl jq git bash && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Optionally copy your source code here if needed
# COPY . .

CMD ["bash"]
