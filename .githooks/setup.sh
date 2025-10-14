#!/bin/bash

# Setup script for Git hooks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up Git hooks...${NC}"

# Make hooks executable
chmod +x .githooks/pre-commit .githooks/commit-msg

# Configure Git to use the hooks directory
git config core.hooksPath .githooks

echo -e "${GREEN}✓ Git hooks configured successfully!${NC}"
echo ""
echo "The following hooks are now active:"
echo "  - pre-commit: Runs code quality checks before each commit"
echo "  - commit-msg: Validates conventional commit message format"
echo ""
echo "To bypass hooks (not recommended): git commit --no-verify"
