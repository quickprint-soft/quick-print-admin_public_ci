#!/bin/bash
set -euo pipefail

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "Error: GITHUB_TOKEN is empty"
  exit 1
fi

TARGET_BRANCH="${1:-main}"
WORKFLOW_FILE="quickprint_release_manual.yml"
REPO="quickprint-soft/quick-print-admin_public_ci"

curl --fail --silent --show-error -X POST \
  "https://api.github.com/repos/${REPO}/actions/workflows/${WORKFLOW_FILE}/dispatches" \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -d "{\"ref\":\"main\",\"inputs\":{\"target_branch\":\"${TARGET_BRANCH}\"}}"

echo
echo "Triggered ${WORKFLOW_FILE} for branch: ${TARGET_BRANCH}"
