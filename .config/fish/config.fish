abbr --add ag rg
abbr --add cd 'z'
abbr --add cdf '~/Repositories/fun'
abbr --add cdn '~/Notes'
abbr --add cdr '~/Repositories'
abbr --add cdv '~/.config/nvim'
abbr --add dtc 'find . -type d -name ".terragrunt-cache" -exec rm -rf "{}" \;'
abbr --add gc 'git commit'
abbr --add gcl 'git clone'
abbr --add gcm 'git cm'
abbr --add gco 'git checkout'
abbr --add la 'exa --git --links --all --long'
abbr --add ll 'exa -l --git --links'
abbr --add mux tmuxinator
abbr --add tm tmux
abbr --add a tmux a
abbr --add rc 'bundle exec rails console'
abbr --add rs 'bundle exec rails server'
abbr --add rr 'bundle exec rails routes --expanded'
abbr --add sk 'bundle exec sidekiq'
abbr --add t 'bundle exec rspec --format p'
abbr --add tg terragrunt
# abbr --add v 'nvim (fzf-tmux --height 40% --info inline --border --reverse --preview \'cat {}\')'
abbr --add vim nvim
abbr --add vimdiff 'nvim -d'
abbr --add hx helix
abbr --add y yadm
abbr --add pythons "asdf list-all python | grep --color=never -P '^\d{1,2}.\d{1,2}.\d{1,2}'"
abbr --add rubies "asdf list-all ruby | grep --color=never -P '^\d{1,2}.\d{1,2}.\d{1,2}'"
abbr --add cdhtg "cd ~/Repositories/hmrc/trade-tariff-platform-terragrunt"
abbr --add cdhtm "cd ~/Repositories/hmrc/trade-tariff-platform-terraform-modules"
abbr --add tap "terragrunt run-all plan"
abbr --add taa "terragrunt run-all apply"

abbr --add hm '~/Repositories/hmrc'
abbr --add admin '~/Repositories/hmrc/trade-tariff-admin'
abbr --add back '~/Repositories/hmrc/trade-tariff-backend'
abbr --add front '~/Repositories/hmrc/trade-tariff-frontend'
abbr --add cds '~/Repositories/hmrc/trade-tariff-search-query-parser'
abbr --add fpo '~/Repositories/hmrc/trade-tariff-lambdas-fpo-search'
abbr --add docs '~/Repositories/hmrc/trade-tariff-api-docs'
abbr --add duty '~/Repositories/hmrc/trade-tariff-duty-calculator'
abbr --add cdt '~/Repositories/hmrc/trade-tariff-testing'
abbr --add sign /home/william/Repositories/hmrc/signon
abbr --add uktt /home/william/Repositories/hmrc/uktt

abbr --add pom '~/Repositories/pomegranate'
abbr --add api '~/Repositories/pomegranate/prognostic-engine-api'
abbr --add cdp '~/Repositories/pomegranate/prognostic-engine'
abbr --add cdtc '~/Repositories/pomegranate/terraform-config'
abbr --add cdtm '~/Repositories/pomegranate/terraform-modules'

abbr --add gr 'go run'
abbr --add gb 'go build'

abbr --add pbcopy 'xclip -selection clipboard'
abbr --add pbpaste 'xclip -selection clipboard -o'

abbr --add g 'git'

function prepend_to_path
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

function prepend_to_info
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx INFOPATH "$argv[1]" $PATH
        end
    end
end

prepend_to_path "$HOME/bin"
prepend_to_path "$HOME/.local/bin"
prepend_to_path /usr/local/bin
prepend_to_path /home/william/bin
prepend_to_path "~/.local/share/coursier/bin"
prepend_to_path /usr/local/protobuf/bin

set -gx ASDF_RUBY_BUILD_VERSION master
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx LESS -R
set -gx GIT_PAGER delta
set -gx fish_greeting ""
set -gx SAM_CLI_TELEMETRY 0
set -gx MANPAGER 'nvim +Man!'
set -gx PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -gx RUBYOPT --enable-yjit
set -gx PAGER ' less --raw-control-chars -F -X'
set -gx USE_SSO "false" # Get to work with TTY

if [ (uname) = Darwin ]
else
    # Linux Brew set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
    set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
    set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"

    prepend_to_info "/home/linuxbrew/.linuxbrew/share/info"
    prepend_to_info /usr/share/terminfo

    set -gx fish_user_paths "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths
    set -gx theme_nerd_fonts yes
end

function hmrc_env
    clear_env
    set -gx AWS_PROFILE hmrc
    set -gx AWS_REGION eu-west-2
    set -gx AWS_DEFAULT_REGION eu-west-2
    set -gx REGION eu-west-2
    export AWS_REGION=eu-west-2
    export AWS_DEFAULT_REGION=eu-west-2
end

function trade_tariff_ci_account_env
    clear_env
    set -gx AWS_PROFILE trade-tariff-ci-account
    set -gx AWS_REGION eu-west-2
    set -gx AWS_DEFAULT_REGION eu-west-2
    set -gx REGION eu-west-2
end

function trade_tariff_bot_env
    clear_env
    set -gx AWS_PROFILE trade-tariff-bot
    set -gx AWS_REGION eu-west-2
    set -gx AWS_DEFAULT_REGION eu-west-2
    set -gx REGION eu-west-2
end

function trade_tariff_dit_backups_accunt_env
    clear_env
    set -gx AWS_PROFILE trade-tariff-dit-backups-account
    set -gx AWS_REGION eu-west-2
    set -gx AWS_DEFAULT_REGION eu-west-2
    set -gx REGION eu-west-2
end

function pomegranate_env
    clear_env
    set -gx AWS_PROFILE pomegranate
    set -gx AWS_REGION eu-west-2
    set -gx AWS_DEFAULT_REGION eu-west-2
    set -gx REGION eu-west-2
end

function personal_env
    clear_env
    set -gx AWS_PROFILE personal
    set -gx AWS_REGION eu-west-2
    set -gx AWS_DEFAULT_REGION eu-west-2
    set -gx REGION eu-west-2
end

function clear_env -d "Clears all AWS environment variables"
    set -e AWS_REGION
    set -e AWS_PROFILE
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN
    set -e AWS_DEFAULT_REGION
end

function harsh -d "Danger find pids relating to program and harsh kill them"
    for pid in (ps uax | grep $argv[1] | grep -v grep | awk '{print $2}')
        sudo kill -9 $pid
    end
end

function install_notes
    if not test -e "$HOME/Notes/"
        git clone git@github.com:willfish/notes.git "$HOME/Notes"
    end
end

alias update-nvim-nightly='asdf uninstall neovim ref:master; asdf install neovim ref:master'

function notes_on -d "Retrieve a given day's notes"
    set -l on_date $argv[1]
    set -l notes_file $argv[2]
    set -l notes_directory "$HOME/Notes/$on_date"
    set -l fully_qualified_notes_file "$notes_directory/$notes_file"
    set -l template_file "$HOME/Notes/templates/$notes_file"

    install_notes

    if not test -e $fully_qualified_notes_file
        mkdir -p $notes_directory
        cp $template_file $fully_qualified_notes_file

        if [ (uname) = Darwin ]
            sed -i '' "s/TodaysDate/$on_date/" $fully_qualified_notes_file
        else
            sed -i "s/TodaysDate/$on_date/" $fully_qualified_notes_file
        end
    end

    pushd $notes_directory
    nvim $fully_qualified_notes_file
    popd
end

function tomorrow -d "Open tomorrow's notes"
    notes_on (date +%F -d "tomorrow") today.md
end

function today -d "Open today's notes"
    notes_on (date +%F) today.md
end

function yesterday -d "Open yesterday's notes"
    notes_on (date +%F -d "yesterday") today.md
end

source ~/.asdf/asdf.fish

function show_stashes
    for stash in (git stash list | awk '{print $1}' | sed 's/://')
        git stash show $stash
    end
end

function log_for
    set -l previous (pwd)
    set -l url $argv[1]
    set -l repo $argv[2]
    set -l sha1 (curl --silent $url | jq '.git_sha1' | tr -d '"')

    cd ~/Repositories/hmrc
    mkdir -p release-notes
    cd release-notes
    rm -rf $repo
    git clone --quiet https://github.com/trade-tariff/$repo.git
    cd $repo

    echo "*$repo*"
    echo
    echo "_"$sha1"_"
    echo
    git --no-pager log --merges HEAD...$sha1 --format="format:- %b" --grep 'Merge pull request'
    echo
    echo

    cd $previous
end

function frontend_log
    log_for "https://www.trade-tariff.service.gov.uk/healthcheck" trade-tariff-frontend
end

function backend_log
    log_for "https://www.trade-tariff.service.gov.uk/api/v2/healthcheck" trade-tariff-backend
end

function duty_log
    log_for "https://www.trade-tariff.service.gov.uk/duty-calculator/healthcheck" trade-tariff-duty-calculator
end

function admin_log
    log_for "https://admin.trade-tariff.service.gov.uk/healthcheck" trade-tariff-admin
end

function search_query_log
    log_for "https://www.trade-tariff.service.gov.uk/api/search/healthcheck" trade-tariff-search-query-parser
end


function all_logs
    frontend_log
    backend_log
    duty_log
    admin_log
    search_query_log
end

function flask_up -d 'Loads a flask environment and app'
    set -gx FLASK_APP flaskr
    set -gx FLASK_ENV development
    source venv/bin/activate.fish
    source .env.development
    flask run
    deactivate
    set -e FLASK_ENV
    set -e FLASK_APP
end

source ~/.config/fish/secrets.fish

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 364a82
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

fzf_configure_bindings --directory=\cf --git_log=\co --git_status=\cs

function box
    set -l environment (echo -e "development\nstaging\nproduction" | fzf)
    set -l key
    set -l host

    set -l environment (echo $environment | tr -d '\n')

    if test $environment = development
        echo "development environment"
        set host "18.171.95.123"
        set key '~/Downloads/restore-development.pem'
    else if test $environment = staging
        echo "staging environment"
        set host "ec2-13-42-116-249.eu-west-2.compute.amazonaws.com"
        set key '~/Downloads/jumpbox.pem'
    else if test $environment = production
        echo "production environment"
        set host "ec2-3-8-173-245.eu-west-2.compute.amazonaws.com"
        set key '~/Downloads/jumpbox-prod.pem'
    else
        echo "Unknown environment $environment"
    end

    echo "Connecting to $host"
    echo "ssh -i $key ec2-user@$host"
    ssh -i $key ec2-user@$host
end

zoxide init fish | source
