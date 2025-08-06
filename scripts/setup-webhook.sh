#!/bin/bash
set -euo pipefail

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "❌ jq is required but not found. Exiting."
  exit 1
fi

# --------- Configuration (update as needed) ---------
GITHUB_REPO="vikasrajput0112/webhook-pipeline"     # Format: username/repo
JENKINS_WEBHOOK_URL="http://your-jenkins-url/github-webhook/"  # Replace with your Jenkins webhook endpoint
GITHUB_API="https://api.github.com"

# --------- Token Validation ---------
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "❌ GITHUB_TOKEN is not set. Please inject it as a Jenkins credential."
  exit 1
fi

echo "🔍 Checking for existing webhook..."

# --------- GitHub API Request ---------
RESPONSE=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" \
  "${GITHUB_API}/repos/${GITHUB_REPO}/hooks")

# Debug print the response
echo "📦 GitHub API raw response:"
echo "$RESPONSE" | jq .

# --------- Check Response Type ---------
if ! echo "$RESPONSE" | jq -e 'type == "array"' > /dev/null; then
  echo "❌ ERROR: GitHub did not return an array. Possible authentication error."
  exit 1
fi

# --------- Check for Existing Webhook ---------
EXISTING=$(echo "$RESPONSE" | jq -r ".[] | select(.config.url == \"${JENKINS_WEBHOOK_URL}\")")

if [ -n "$EXISTING" ]; then
  echo "✅ Webhook already exists. Skipping creation."
  exit 0
fi

# --------- Create Webhook ---------
echo "➕ Creating webhook..."
curl -s -X POST -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "web",
    "active": true,
    "events": ["push"],
    "config": {
      "url": "'"${JENKINS_WEBHOOK_URL}"'",
      "content_type": "json"
    }
  }' \
  "${GITHUB_API}/repos/${GITHUB_REPO}/hooks" | jq .

echo "✅ Webhook created successfully."
