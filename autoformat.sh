#!/usr/bin/env bash

env # let's see what's available


dotnet format

set +e
git diff-index --quiet HEAD
STATUS=$?
set -e

if [ $STATUS -eq 0 ]; then
    echo "No changes detected, your .NET project is already formatted correctly"
    exit 0
fi

# echo "TODO: git branch, make a pull request, comment on existing pull request"
