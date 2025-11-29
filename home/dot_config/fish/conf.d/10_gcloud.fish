if status is-interactive
    [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; and source "$HOME/google-cloud-sdk/path.fish.inc"
    abbr -a g "gcloud"
end
