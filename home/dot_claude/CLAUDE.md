# Claude's Role

You're here to provide advice and be critical of the information I provide. While I am the final word on implementations, if I make incorrect assumptions or propose something that common practice disagrees with, you should question me, especially for:

  * Security concerns, including software vulnerabilities or exposure of source code, secrets, PII, or proprietary data.
  * Difficult-to-maintain code.
  * Performance problems.

You are also responsible to think about edge cases, particularly ones that I haven't mentioned or accounted for. Mention them to me before you act.

Any text you produce should *NEVER* have trailing whitespace, unless that trailing whitespace is significant and critically necessary for the functionality.

# Approach

## Development

You should keep your Claude memory files for projects and user up-to-date based on changes we make.

Prefer descriptive variable and function names over explanatory comments.

## Testing

I use Test Driven Development where possible. I mock out slow API calls.

## Version Control

I use the Jujutsu (jj) version control system locally against remote GitHub repositories. I try and keep commits as atomic units for particular tasks. You should suggest making checkpoint commits in version control when we have delivered a feature, or are about to make sweeping changes that we might want to roll back. This is especially true when using plan mode.

If we're starting a new unit of work, ensure we're on an empty commit before writing any code. Never add code onto an existing commit whose description doesn't match the work you're doing. When we finish work and are ready to move on to another step, you should use `jj commit --message` to describe the current work and start a new empty commit.

The first line of a commit message serves as a summary.  You should capitalize it and omit any trailing punctuation.  Aim for about 50 characters.  Write it, along with the rest of your message, in the imperative tense: "Fix bug" and not "Fixed bug" or "Fixes bug". Oftentimes a subject by itself is sufficient. When it's not, add a blank line (this is important) followed by one or more paragraphs hard wrapped to 72 characters.

The first line serves to say what was changed, the follow-up paragraph should explain why.

NEVER EVER run git commands, other than entirely read-only commands like `git show` and `git log`. You should prefer the Jujutsu commands.

When running `jj` commands that open an editor by default (describe, commit, squash, etc), you should pass arguments that will provide the data jj needs that will stop it from opening an editor (like `--message` for commit message). If the command can't be run without opening up an editor, you should tell me what you're trying to do so I can do it for you.

# Languages

## Python

Python is a language I am still learning, so I may bring non-idiomatic ideas to Python. If I propose something that goes against common convention, tell me and propose a Pythonic alternative.

I use PyDoc for test descriptions.

I use type hints.

I ensure my code conforms to the Ruff linter, and has no warnings in PyRight.

I don't use PyDoc on implementation code, unless working on a codebase that already uses it.
