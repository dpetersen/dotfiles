---
name: jira
description: MANDATORY skill for ANY acli jira command. YOU MUST use this skill for ALL Jira queries - both initial searches AND follow-up queries. NEVER run acli jira commands directly outside this skill. This includes viewing tickets, comments, attachments, sprints, boards, searches, and ANY other acli jira operation. Examples requiring this skill - "show my tickets", "what's in EXPL-123?", "show comments", "list sprint items". CRITICAL - commands are allowlisted in this skill but NOT outside it, so running them directly will require permission prompts.
allowed-tools: Bash(acli jira auth status:*), Bash(acli jira workitem search:*), Bash(acli jira workitem view:*), Bash(acli jira workitem comment list:*), Bash(acli jira workitem attachment list:*), Bash(acli jira board search:*), Bash(acli jira board list-sprints:*), Bash(acli jira sprint list-workitems:*)
---

# Jira Issue Management with ACLI

Query and read Jira issues using the Atlassian CLI (ACLI).

## CRITICAL USAGE RULES

**YOU MUST USE THIS SKILL FOR EVERY ACLI JIRA COMMAND - NO EXCEPTIONS**

- ✅ CORRECT: Invoke this skill, then run acli commands (allowlisted, no permission needed)
- ❌ WRONG: Run acli jira commands directly (will require permission prompts)

**When to use this skill:**
- Initial queries: "Show my assigned tickets"
- Follow-up queries: "What's in EXPL-123?"
- Viewing details: "Show me the description"
- Reading comments: "What are the comments?"
- Listing attachments: "Are there attachments?"
- Sprint queries: "What's in the current sprint?"
- Board searches: "Find the EXPL board"
- ANY other acli jira operation

**This skill remains active for the entire Jira conversation** - once you start using it, continue using it for all subsequent Jira queries in the same conversation.

## Authentication

Check authentication status:
```bash
acli jira auth status
```

You should be authenticated to your organization's Atlassian instance.

## Finding Assigned Issues

### Basic Search

```bash
# Get all issues assigned to current user
acli jira workitem search --jql "assignee = currentUser()" --paginate

# Get assigned issues in JSON format
acli jira workitem search --jql "assignee = currentUser()" --json

# Count assigned issues
acli jira workitem search --jql "assignee = currentUser()" --count

# Get specific fields only
acli jira workitem search --jql "assignee = currentUser()" --fields "key,summary,status"
```

### Common Search Patterns

```bash
# Assigned to me and in progress
acli jira workitem search --jql "assignee = currentUser() AND status = 'In Progress'"

# Assigned to me in a specific project
acli jira workitem search --jql "assignee = currentUser() AND project = EXPL"

# Unassigned stories in a project
acli jira workitem search --jql "assignee is EMPTY AND project = EXPL AND issuetype = Story"

# High priority issues assigned to me
acli jira workitem search --jql "assignee = currentUser() AND priority = High"
```

### Key Options

- `--jql "JQL_QUERY"` - Jira Query Language filter
- `--limit N` - Maximum number of results
- `--paginate` - Fetch all results by paginating
- `--count` - Show count only
- `--fields "field1,field2,..."` - Specify fields (default: "issuetype,key,assignee,priority,status,summary")
- `--json` - Output as JSON
- `--csv` - Output as CSV

## Reading Issue Details

### View Issue

```bash
# View with default fields (key, issuetype, summary, status, assignee, description)
acli jira workitem view EXPL-123

# View specific fields
acli jira workitem view EXPL-123 --fields "summary,description,status,assignee"

# View all fields in JSON
acli jira workitem view EXPL-123 --fields '*all' --json

# View all except comments
acli jira workitem view EXPL-123 --fields '*all,-comment'

# Open in web browser
acli jira workitem view EXPL-123 --web
```

### List Comments

```bash
# List all comments on an issue
acli jira workitem comment list --key EXPL-123 --paginate

# List recent 10 comments in JSON
acli jira workitem comment list --key EXPL-123 --limit 10 --json

# Order by most recent first
acli jira workitem comment list --key EXPL-123 --order "-created" --paginate
```

### List Attachments

```bash
# List attachments on an issue
acli jira workitem attachment list --key EXPL-123

# List attachments in JSON
acli jira workitem attachment list --key EXPL-123 --json
```

Note: To view or download attachments/images, you'll need to use the issue's web view (`--web` flag) or access them through the Atlassian UI.

## Sprint Queries

Sprint queries require both a board ID and sprint ID. **Check the project's CLAUDE.md for board IDs.**

### Step 1: Find Boards (if board ID not in CLAUDE.md)

```bash
# Search all boards
acli jira board search --paginate

# Search boards by project
acli jira board search --project EXPL

# Search scrum boards
acli jira board search --type scrum --json
```

### Step 2: List Sprints for a Board

```bash
# Get active sprints for board (replace BOARD_ID with value from CLAUDE.md)
acli jira board list-sprints --id BOARD_ID --state active

# Get all sprints in JSON
acli jira board list-sprints --id BOARD_ID --json --paginate

# Get active and future sprints
acli jira board list-sprints --id BOARD_ID --state active,future
```

### Step 3: List Work Items in a Sprint

```bash
# Get all work items in a sprint
acli jira sprint list-workitems --board BOARD_ID --sprint SPRINT_ID --paginate

# Get unassigned items ready for dev
acli jira sprint list-workitems --board BOARD_ID --sprint SPRINT_ID --jql "status = 'To Do' AND assignee is EMPTY"

# Get items in progress
acli jira sprint list-workitems --board BOARD_ID --sprint SPRINT_ID --jql "status = 'In Progress'" --json

# Get specific fields only
acli jira sprint list-workitems --board BOARD_ID --sprint SPRINT_ID --fields "key,summary,status"
```

## Common JQL Patterns

### Status Filtering

```jql
status = 'To Do'
status = 'In Progress'
status = 'Done'
status IN ('To Do', 'Ready for Dev')
```

### Assignee Filtering

```jql
assignee = currentUser()
assignee is EMPTY
assignee = "user@example.com"
```

### Issue Type Filtering

```jql
issuetype = Story
issuetype = Bug
issuetype IN (Story, Bug)
```

### Priority Filtering

```jql
priority = High
priority IN (High, Highest)
```

### Combining Filters

```jql
status = 'To Do' AND assignee is EMPTY
status = 'In Progress' AND assignee = currentUser()
project = EXPL AND issuetype = Story AND status IN ('To Do', 'Ready for Dev')
```

## Output Formats

### Table Format (Default)

Human-readable formatted tables with columns for each field.

Example:
```
Type  Key       Assignee                   Priority  Status  Summary
────────────────────────────────────────────────────────────────────
Bug   EXPL-411  user@example.com           Medium    Done    Fix duplicate records
```

### JSON Format

Machine-readable structured data. Use `--json` flag.

Example:
```json
[
  {
    "key": "EXPL-411",
    "fields": {
      "issuetype": {"name": "Bug"},
      "assignee": {"displayName": "Donald Petersen"},
      "priority": {"name": "Medium"},
      "status": {"name": "Done"},
      "summary": "Fix duplicate records"
    }
  }
]
```

### CSV Format

Spreadsheet-compatible format. Use `--csv` flag (available on most commands).

## Project-Specific Configuration

**IMPORTANT**: Always check the project's `CLAUDE.md` file for:
- Relevant Jira project keys (e.g., EXPL, TEST2, TEST1)
- Board IDs for sprint queries
- Project-specific conventions and status names

The board ID is required for sprint queries and should be documented in each project's CLAUDE.md.

## Examples

### "Show me my assigned stories"

```bash
acli jira workitem search --jql "assignee = currentUser() AND issuetype = Story" --paginate
```

### "What's in EXPL-123?"

```bash
acli jira workitem view EXPL-123
acli jira workitem comment list --key EXPL-123 --paginate
acli jira workitem attachment list --key EXPL-123
```

### "List unassigned stories in the current sprint"

```bash
# First, get the board ID from CLAUDE.md, then get the active sprint ID
acli jira board list-sprints --id BOARD_ID --state active

# Then, list unassigned stories (use sprint ID from above)
acli jira sprint list-workitems --board BOARD_ID --sprint SPRINT_ID --jql "assignee is EMPTY AND issuetype = Story"
```

### "Show me all high-priority bugs in EXPL"

```bash
acli jira workitem search --jql "project = EXPL AND issuetype = Bug AND priority = High" --paginate
```
