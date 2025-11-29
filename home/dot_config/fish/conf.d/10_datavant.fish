if status is-interactive
    abbr -a dvawslogin "aws sso login --sso-session onedatavant"
    abbr -a dvawshelmlogin \
'aws --profile prod ecr get-login-password | \
        helm registry login \
        --username AWS \
        --password-stdin 283241578630.dkr.ecr.us-east-1.amazonaws.com'
end
