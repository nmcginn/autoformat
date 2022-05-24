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

if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    # check for existing comment
    COMMENTS_URL="$GITHUB_API_URL/repos/$GITHUB_REPOSITORY/issues/$PR_NUMBER/comments"
    COMMENTS=`curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X GET "$COMMENTS_URL"`
    USER_COMMENTS=`echo "$COMMENTS" | jq '.[].user.login'`
    # make a comment if we haven't yet
    if [[ "$USER_COMMENTS" != *"github-actions"* ]]; then
        curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X POST -d '{"body": "Your pull request appears to have improperly formatted C# code! Please comment with\n\n```bash\n/format\n```\n\nand I will format your code for you!"}' "$COMMENTS_URL"
    else
        echo "Not commenting, found comments from users $USER_COMMENTS"
    fi
elif [ "$GITHUB_EVENT_NAME" = "comment" ]; then
    echo "someone commented!"
fi

# echo "TODO: git branch, make a pull request, comment on existing pull request"
