#!/bin/bash
#
# sync-upstream.sh
# ================
# Syncs this fork with upstream changes while keeping your customizations
# rebased on top.
#
# WORKFLOW OVERVIEW
# -----------------
# This script implements a "rebase on upstream" workflow:
#
#   upstream/master ──●──●──●──●  (jkillian's commits)
#                              \
#   openvsx-release             ●  (your customization commit)
#
# When upstream gets new commits, this script:
# 1. Fetches the new commits from upstream
# 2. Fast-forwards your local master to match upstream/master
# 3. Rebases your openvsx-release branch onto the updated master
# 4. Force-pushes your rebased branch to your fork
#
# WHY REBASE INSTEAD OF MERGE?
# ----------------------------
# Rebasing keeps your customization commits cleanly on top of upstream,
# making it easy to see exactly what you changed. It also keeps the
# history linear and avoids merge commits.
#
# PREREQUISITES
# -------------
# - Remote 'upstream' points to: git@github.com:jkillian/vscode-custom-local-formatters.git
# - Remote 'origin' points to: git@github.com:simkimsia/vscode-custom-local-formatters.git
# - You have an 'openvsx-release' branch with your customizations
#
# USAGE
# -----
#   ./scripts/sync-upstream.sh
#
# CONFLICT HANDLING
# -----------------
# If conflicts occur during rebase, the script will pause. You'll need to:
# 1. Resolve conflicts manually
# 2. Run: git add <resolved-files>
# 3. Run: git rebase --continue
# 4. Run: git push origin openvsx-release --force-with-lease
#

set -e  # Exit on any error

echo "=========================================="
echo "  Syncing fork with upstream"
echo "=========================================="
echo ""

# Step 1: Fetch upstream
echo "Step 1/4: Fetching upstream changes..."
git fetch upstream
echo "✓ Fetched upstream"
echo ""

# Step 2: Show what's new (if anything)
echo "Step 2/4: Checking for new commits..."
NEW_COMMITS=$(git log --oneline master..upstream/master 2>/dev/null | wc -l | tr -d ' ')
if [ "$NEW_COMMITS" -eq 0 ]; then
    echo "✓ Already up to date with upstream. Nothing to do."
    exit 0
fi
echo "Found $NEW_COMMITS new commit(s) from upstream:"
git log --oneline master..upstream/master
echo ""

# Step 3: Update master branch
echo "Step 3/4: Updating master branch..."
git checkout master
git merge --ff-only upstream/master
git push origin master
echo "✓ Master updated and pushed"
echo ""

# Step 4: Rebase customizations
echo "Step 4/4: Rebasing openvsx-release onto updated master..."
git checkout openvsx-release
git rebase master

# Force push with lease (safer than --force)
git push origin openvsx-release --force-with-lease
echo "✓ openvsx-release rebased and pushed"
echo ""

echo "=========================================="
echo "  Sync complete!"
echo "=========================================="
echo ""
echo "Your openvsx-release branch now has your commits on top of upstream."
echo "Run 'git log --oneline -5' to verify."
