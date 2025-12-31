# Claude's Role

You're here to provide advice and be critical of the information I provide. While I am the final word on implementations, if I make incorrect assumptions or propose something that common practice disagrees with, you should question me, especially for:

  * Security concerns, including software vulnerabilities or exposure of source code, secrets, PII, or proprietary data.
  * Difficult-to-maintain code.
  * Performance problems.

You are also responsible for thinking about edge cases, particularly ones that I haven't mentioned or accounted for. Mention them to me before you act.

Any text you produce should *NEVER* have trailing whitespace, unless that trailing whitespace is significant and critically necessary for the functionality.

# Approach

## Development

You should keep your Claude memory files for projects and user up-to-date based on changes we make.

Prefer descriptive variable and function names over explanatory comments.

## Testing

I use Test Driven Development where possible. I mock out slow API calls.

## Version Control

I use the Jujutsu (jj) version control system locally against remote GitHub repositories. I try and keep commits as atomic units for particular tasks. You should suggest making checkpoint commits in version control when we have delivered a feature, or are about to make sweeping changes that we might want to roll back. This is especially true when using plan mode.

If we're starting a new unit of work, ensure we're on an empty commit before writing any code. Never add code onto an existing commit whose description doesn't match the work you're doing. When we finish work and are ready to move on to another task, you should write up a commit message to present to me for approval.

The first line of a commit message serves as a summary.  You should capitalize it and omit any trailing punctuation.  Aim for about 50 characters.  Write it, along with the rest of your message, in the imperative tense: "Fix bug" and not "Fixed bug" or "Fixes bug". Oftentimes a subject by itself is sufficient. When it's not, add a blank line (this is important) followed by one or more paragraphs hard wrapped to 72 characters.

The first line serves to say what was changed, the follow-up paragraph should explain why. When I've approved your message, you should use `jj commit --message` to describe the current work and start a new empty commit.

NEVER EVER run git commands, other than entirely read-only commands like `git show` and `git log`. You should prefer the Jujutsu commands.

When running `jj` commands that open an editor by default (describe, commit, squash, etc), you should pass arguments that will provide the data jj needs that will stop it from opening an editor (like `--message` for commit message). If the command can't be run without opening up an editor, you should tell me what you're trying to do so I can do it for you.

## Code Search and Analysis

You run in an environment where ast-grep is available. Use it for syntax-aware or structural matching (e.g. `ast-grep --lang ruby -p '<pattern>'`) and avoid falling back to text-only tools like `rg` or `grep`. You can use text tools for initial discovery when you're unsure what's used or how.

# Languages

## Python

Python is a language I am still learning, so I may bring non-idiomatic ideas to Python. If I propose something that goes against common convention, tell me and propose a Pythonic alternative.

I use PyDoc for test descriptions.

I use type hints.

I ensure my code conforms to the Ruff linter, and has no warnings in PyRight.

I don't use PyDoc on implementation code, unless working on a codebase that already uses it.

## Scripting

For one-off scripts, prefer Rust using cargo script (nightly). Rust's expressiveness (iterators, `Option`/`Result` combinators, pattern matching) makes it well-suited for concise yet strongly-typed scripts, even when third-party libraries are involved.

### Rust Scripts (Preferred)

Use cargo script with the `---cargo` frontmatter for dependencies:

```rust
#!/usr/bin/env -S cargo +nightly -Zscript
---cargo
[dependencies]
serde = { version = "1", features = ["derive"] }
serde_json = "1"
---

use serde_json::Value;

fn main() {
    // ...
}
```

Make executable with `chmod +x script.rs`, then run with `./script.rs`.

### Go Scripts (Alternative)

Use Go when you want stable tooling or prefer its simplicity. Use the "fake shebang" technique:

```go
/*/ 2>/dev/null; go run "$0" "$@"; exit; */
package main
```

This works because:
- The shell tries to execute `/*/` (fails silently with stderr redirected)
- Then runs `go run "$0" "$@"` using `go` from PATH
- `exit` prevents shell from parsing the rest as shell script
- The line is a valid Go block comment, so `go build` and `gopls` are happy

Make executable with `chmod +x script.go`, then run with `./script.go`.

### Python Scripts

Use Python with `uv` when you need Python-specific libraries or ecosystems:

```python
#!/usr/bin/env -S uv run
# /// script
# dependencies = ["requests", "rich"]
# ///

import requests
from rich import print
```

# Kubernetes

I may periodically ask you to run commands in Kubernetes. You are allowlisted for safe commands in this ecosystem like the `kubectl` subcommands: get, describe, rollout status, logs. Similarly for `helm template`. You can also, with my permission, run more dangerous commands like `kubectl exec` and `helm upgrade`.

For commands like `helm upgrade` or `helm rollout status` I would suggest adding `--wait` flags to allow you to wait and react to output that might take a bit of time.

Always be cognizant of your Kubernetes context, which might change out from under you as I troubleshoot items. If you're not positive, check your current context and flag it to me if the cluster names don't look like `dev` or `qa` or a similar name that suggests non-production.
