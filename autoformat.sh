#!/usr/bin/env bash

env # useful for debugging (pls remove)

git config --global --add safe.directory /github/workspace

dotnet format "$INPUT_PROJECT"

set +e
git diff-index HEAD # potentially useful for troubleshooting
git diff-index --quiet HEAD
STATUS=$?
set -e

if [ $STATUS -eq 0 ]; then
    echo "No changes detected, your .NET project is already formatted correctly"
    exit 0
fi

PR_NUMBER=`echo "$GITHUB_REF_NAME" | awk -F / '{print $1}'`
echo $PR_NUMBER

# echo "TODO: git branch, make a pull request, comment on existing pull request"
