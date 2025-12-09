if status is-interactive
    set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

    # Used by coc-yaml in Neovim for K8s schema validation
    set -gx KUBERNETES_SCHEMA_URL "https://raw.githubusercontent.com/garethr/kubernetes-json-schema/master/v1.14.0-standalone-strict/all.json"

    abbr -a k "kubectl"
    abbr -a kc "kubectx"
    abbr -a kn "kubens"
    abbr -a sterne "stern -Eistio -eokcomputer"

    # Hotkeys for switching context and namespace
    bind \ck "kubectx; commandline --function repaint"
    bind -M insert \ck "kubectx; commandline --function repaint"
    bind \cn "kubens; commandline --function repaint"
    bind -M insert \cn "kubens; commandline --function repaint"
end
