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
abbr --add mux 'tmuxinator'
abbr --add ny '~/.config/nyxt'
abbr --add rc 'bundle exec rails c'
abbr --add rs 'bundle exec rails s'
abbr --add t 'bundle exec rspec'
abbr --add tg 'terragrunt'
abbr --add v 'nvim'
abbr --add vim 'nvim'
abbr --add vimdiff 'nvim -d'

abbr --add hm '~/Repositories/hmrc'
abbr --add admin '~/Repositories/hmrc/trade-tariff-admin'
abbr --add back '~/Repositories/hmrc/trade-tariff-backend'
abbr --add front '~/Repositories/hmrc/trade-tariff-frontend'
abbr --add cds '~/Repositories/hmrc/trade-tariff-search-query-parser'
abbr --add docs '~/Repositories/hmrc/trade-tariff-api-docs'
abbr --add duty '~/Repositories/hmrc/trade-tariff-duty-calculator'
abbr --add cdt '~/Repositories/hmrc/trade-tariff-testing'
abbr --add sign '/home/william/Repositories/hmrc/signon'
abbr --add uktt '/home/william/Repositories/hmrc/uktt'

abbr --add pom '~/Repositories/pomegranate'
abbr --add api '~/Repositories/pomegranate/prognostic-engine-api'
abbr --add cdp '~/Repositories/pomegranate/prognostic-engine'
abbr --add cdtc '~/Repositories/pomegranate/terraform-config'
abbr --add cdtm '~/Repositories/pomegranate/terraform-modules'

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
prepend_to_path "/usr/local/bin"
prepend_to_path "/home/william/bin"
prepend_to_path "~/.local/share/coursier/bin"

set -gx ASDF_RUBY_BUILD_VERSION "master"
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx LESS "-R"
set -gx GIT_PAGER "less"
set -gx fish_greeting ""
set -gx SAM_CLI_TELEMETRY 0
set -gx MANPAGER 'nvim +Man!'
set -gx PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -gx GIT_TERMINAL_PROMPT 1
set -gx RUBYOPT "--enable-yjit"

if [ (uname) = "Darwin" ]
else
  # Linux Brew set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
  set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
  set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";

  prepend_to_info "/home/linuxbrew/.linuxbrew/share/info"
  prepend_to_info "/usr/share/terminfo"

  set -gx fish_user_paths "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths;
  set -gx theme_nerd_fonts yes
end

function hmrc_env
  clear_env
  set -gx AWS_PROFILE hmrc
  set -gx AWS_REGION eu-west-2
  set -gx AWS_DEFAULT_REGION eu-west-2
  set -gx REGION eu-west-2
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

    if [ (uname) = "Darwin" ]
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

function spaces
  cf spaces | grep -v name | grep -v '^$' | grep -v 'Getting'
end

function apps
  set -l apps_file ~/.config/cf/apps.txt

  if not test -e $apps_file
    cf apps | grep -v name | grep -v Getting | grep -v '^$' | awk '{ print $1 }' > $apps_file
  end
  cat $apps_file
end

function services
  set -l services_file ~/.config/cf/services.txt

  if not test -e $services_file
    cf services | grep -v name | grep -v Getting | grep -v '^$' | awk '{ print $1 }' > $services_file
  end

  cat $services_file
end

function clear_apps
  set -l apps_file ~/.config/cf/apps.txt

  if test -e $apps_file
    rm $apps_file
  end
end

function clear_services
  set -l services_file ~/.config/cf/services.txt

  if test -e $services_file
    rm $services_file
  end
end

function cf_psql
  set -l service (services | grep postgres | fzf)

  cf conduit $service -- psql
end

function cf_ssh
  set -l app (apps | fzf)

  echo $app | grep "signon"

  if test $status -eq 0
    cf ssh $app -t -c "export PATH='/usr/local/bundle/bin/bin:/usr/local/bundle/bin:/opt/bitnami/ruby/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'; cd /app; sh"
  else
    cf ssh $app -t -c "export PATH='/bin/:/usr/local/bin:/usr/bin'; cd /app; sh"
  end
end

function cf_rb
  set -l app (apps | grep -e frontend -e backend -e admin -e duty -e signon | fzf)

  echo $app | grep "signon"

  if test $status -eq 0
    cf ssh $app -t -c "export PATH='/usr/local/bundle/bin/bin:/usr/local/bundle/bin:/opt/bitnami/ruby/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'; cd /app; bundle exec rails c"
  else
    cf ssh $app -t -c "export PATH='/bin/:/usr/local/bin:/usr/bin'; cd /app; bundle exec rails c"
  end
end

function cf_flush
  set -l service (services | grep redis | fzf)

  cf conduit $service -- redis-cli FLUSHALL
end

function cf_flush_all
  set -l workers (apps | grep worker | grep -v signon)

  for worker in $workers
    cf ssh $worker -t -c "export PATH='/bin/:/usr/local/bin:/usr/bin'; cd /app; /usr/local/bin/bundle exec rails runner 'Rails.cache.clear'"
  end
end

function cf_bundle_exec
  set -l workers (apps | grep worker | grep -v signon)

  for worker in $workers
    cf ssh $worker -t -c "export PATH='/bin/:/usr/local/bin:/usr/bin'; cd /app; /usr/local/bin/bundle exec $argv"
  end
end

function cf_info
  set -l service (services | grep redis | fzf)

  cf conduit $service -- redis-cli info
end

function cf_psql
  set -l service (services | grep postgres | fzf)

  cf conduit $service -- psql
end

function backup_manifests
  set -l current_directory (pwd)

  cd /home/william/Repositories/hmrc/manifests-backup

  for space in (cat spaces)
    cf target -s $space
    mkdir -p $space/

    pushd $space

    apps > apps
    services > services

    for app in (cat apps)
      cf create-app-manifest $app
      echo "App $app with guid $(cf app $app --guid)" >> guids.txt
    end

    for service in (cat services)
      echo "Service $service with guid $(cf service $service --guid)" >> guids.txt
    end

    popd
  end

  cd $current_directory
end

function cdn_invalidate_production
  aws cloudfront create-invalidation --distribution-id EFNZFAYYYB7R4 --paths "/" "/*"
end

function cdn_invalidate_development
  aws cloudfront create-invalidation --distribution-id E3CTPYC9CP3SAZ --paths "/" "/*"
end

function cdn_invalidate_staging
  aws cloudfront create-invalidation --distribution-id E1IATQ3JO4BWV6 --paths "/" "/*"
end

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
  log_for "https://www.trade-tariff.service.gov.uk/healthcheck" "trade-tariff-frontend"
end

function backend_log
  log_for "https://www.trade-tariff.service.gov.uk/api/v2/healthcheck" "trade-tariff-backend"
end

function duty_log
  log_for "https://www.trade-tariff.service.gov.uk/duty-calculator/healthcheck" "trade-tariff-duty-calculator"
end

function admin_log
  log_for "https://tariff-admin-production.london.cloudapps.digital/healthcheck" "trade-tariff-admin"
end

function search_query_log
  log_for "https://www.trade-tariff.service.gov.uk/api/search/healthcheck" "trade-tariff-search-query-parser"
end


function all_logs
  frontend_log
  backend_log
  duty_log
  admin_log
  search_query_log
end

function clear_all_caches
  set -l current_space (cf target | grep space | awk '{print $2}')

  hmrc_env; cf_flush_all; eval "cdn_invalidate_$current_space"
end

function clear_conduit
  for space in development staging
    cf target -s $space

    set -l conduit_apps (cf apps | grep conduit | awk '{print $1}' )

    for app in $conduit_apps
      cf delete $app
    end
  end
end

function flask_up -d 'Loads a flask environment and app'
  set -gx FLASK_APP flaskr
  set -gx FLASK_ENV development
  source dev/bin/activate.fish
  source .env.development
  flask run
  deactivate
  set -e FLASK_ENV
  set -e FLASK_APP
end

source ~/.config/fish/secrets.fish
