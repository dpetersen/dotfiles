# Jump to the root of the repo you're currently in, if any.
# Prefers jj, falls back to git.
function gcd
    set -lx JJ_ROOT (jj root 2>/dev/null)
    if test $status -eq 0
        cd $JJ_ROOT
    else
        set -lx TOPLEVEL (git rev-parse --show-toplevel 2>/dev/null)
        if test $status -eq 0
            cd $TOPLEVEL
        end
    end
end

if status is-interactive
    abbr -a gs "git status"
    abbr -a gc "git checkout"
    abbr -a gcv 'git commit -v'
    abbr -a gfp 'git fetch origin; and git pull'
    abbr -a gfpt 'git fetch origin; and git pull; and git trim'
end
