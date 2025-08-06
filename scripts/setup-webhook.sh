#!/bin/bash

# Exit on error and undefined variables
set -euo pipefail

# -------- Configuration --------
GITHUB_REPO="vikasrajput0112/webhook-pipeline"         # format: org_or_user/repo
JENKINS_WEBHOOK_URL="http://your-jenkins-domain/github-webhook/"   # replace this!
GITHUB_API="https://api.github.com"

# -------- Validation --------
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "❌ GITHUB_TOKEN is not set. Please inject it via Jenkins credentials."
  exit 1
fi

# -------- Check if webhook already exists --------
echo "🔍 Checking existing webhooks for $GITHUB_REPO ..."

EXISTING=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" \
  "${GITHUB_API}/repos/${GITHUB_REPO}/hooks" | \
  jq -r ".[] | select(.config.url == \"${JENKINS_WEBHOOK_URL}\")")

if [ -n "$EXISTING" ]; then
  echo "✅ Webhook already exists. Skipping creation."
  exit 0
fi

# -------- Create webhook --------
echo "➕ Creating webhook for $GITHUB_REPO ..."

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
  "${GITHUB_API}/repos/${GITHUB_REPO}/hooks" | jq

echo "✅ Webhook created successfully."
