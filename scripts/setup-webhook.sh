#!/bin/bash

# Fail on error
set -e

# Required env variables
GITHUB_REPO="your-org-name/your-repo-name"
JENKINS_URL="http://your-jenkins-domain/github-webhook/"
TOKEN="${GITHUB_TOKEN}"

# Check existing webhooks
EXISTING_HOOK=$(curl -s -H "Authorization: token ${TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPO}/hooks | jq '.[] | select(.config.url=="'"${JENKINS_URL}"'")')

if [ -z "$EXISTING_HOOK" ]; then
    echo "Creating new webhook..."

    curl -X POST -H "Authorization: token ${TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{
            "name": "web",
            "active": true,
            "events": ["push"],
            "config": {
                "url": "'"${JENKINS_URL}"'",
                "content_type": "json"
            }
        }' \
        https://api.github.com/repos/${GITHUB_REPO}/hooks

    echo "Webhook created!"
else
    echo "Webhook already exists. Skipping creation."
fi
