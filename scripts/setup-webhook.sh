#!/bin/bash
set -euo pipefail

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "❌ jq is required but not found. Exiting."
  exit 1
fi

# Config — update as needed
GITHUB_REPO="vikasrajput0112/webhook-pipeline"  # Format: username/repo
JENKINS_WEBHOOK_URL="http://your-jenkins-url/github-webhook/"  # Replace with your Jenkins public URL
GITHUB_API="https://api.github.com"

# Validate token
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "❌ GITHUB_TOKEN not set. Inject it via Jenkins credentials."
  exit 1
fi

# Check if webhook already exists
echo "🔍 Checking for existing webhook..."
EXISTING=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}"   "${GITHUB_API}/repos/${GITHUB_REPO}/hooks" |   jq -r ".[] | select(.config.url == \"${JENKINS_WEBHOOK_URL}\")")

if [ -n "$EXISTING" ]; then
  echo "✅ Webhook already exists. Skipping."
  exit 0
fi

# Create new webhook
echo "➕ Creating webhook..."
curl -s -X POST -H "Authorization: token ${GITHUB_TOKEN}"   -H "Content-Type: application/json"   -d '{
    "name": "web",
    "active": true,
    "events": ["push"],
    "config": {
      "url": "'"${JENKINS_WEBHOOK_URL}"'",
      "content_type": "json"
    }
  }'   "${GITHUB_API}/repos/${GITHUB_REPO}/hooks" | jq

echo "✅ Webhook setup complete."
