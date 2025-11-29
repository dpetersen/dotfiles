# Fixes for devcontainer environments

# Some environments set PAGER to something dumb, like `less` with no arguments
# so it's launching less for things that are 2 lines long.
if set -q PAGER
    set -e PAGER
end
