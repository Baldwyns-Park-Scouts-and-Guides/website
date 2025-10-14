#!/bin/bash

# Setup script for Git hooks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up Git hooks...${NC}"

# Check if hooks are already configured
CURRENT_HOOKS_PATH=$(git config --get core.hooksPath 2>/dev/null || echo "")

if [ "$CURRENT_HOOKS_PATH" = ".githooks" ]; then
    echo -e "${GREEN}✓ Git hooks are already configured correctly${NC}"
    echo "Current hooks path: $CURRENT_HOOKS_PATH"
else
    echo "Current hooks path: ${CURRENT_HOOKS_PATH:-"(default .git/hooks)"}"
    echo "Configuring Git to use .githooks directory..."

    # Make hooks executable
    chmod +x .githooks/pre-commit .githooks/commit-msg

    # Configure Git to use the hooks directory
    git config core.hooksPath .githooks

    echo -e "${GREEN}✓ Git hooks configured successfully!${NC}"
fi
echo ""
echo "The following hooks are now active:"
echo "  - pre-commit: Runs code quality checks before each commit"
echo "  - commit-msg: Validates conventional commit message format"
echo ""
echo "To bypass hooks (not recommended): git commit --no-verify"
