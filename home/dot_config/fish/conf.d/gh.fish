# Create a PR in a browser using the @ revision of JJ. Must have pushed and have a bookmark.
 abbr -a ghpr 'gh pr create --head (jj log -r @ --no-graph -T "separate(\" \", local_bookmarks)" --color=never | awk "{print \$1}") --web'

# Follow logs for my most recently run GHA
abbr -a ghame "gh run watch \$(gh run list --limit 1 --json databaseId --jq ".[0].databaseId" --user dpetersen)"

eval (gh completion fish)
