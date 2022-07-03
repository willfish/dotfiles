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

set -gx ASDF_RUBY_BUILD_VERSION "master"
set -gx EDITOR "/home/william/.asdf/shims/nvim"
set -gx VISUAL "/home/william/.asdf/shims/nvim"
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx LESS "-R"
set -gx GIT_PAGER "less"
set -gx fish_greeting ""
set -gx SAM_CLI_TELEMETRY 0
set -gx MANPAGER 'nvim +Man!'
set -gx PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig
set -gx VK_ICD_FILENAMES /usr/share/vulkan/icd.d/nvidia_icd.json # https://vulkan.lunarg.com/issue/home?limit=10;q=;mine=false;org=false;khronos=false;lunarg=false;indie=false;status=new,open - debugging issue with loading vkcube
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -gx GIT_TERMINAL_PROMPT 1
set -gx FLASK_APP flaskr
set -gx FLASK_ENV development

if [ (uname) = "Darwin" ]
else
  # Linux Brew
  set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
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
end

function cf_psql
  set -l service (services | grep postgres | fzf)

  cf conduit $service -- psql
end

function pomegranate_env
  clear_env
  set -gx AWS_PROFILE pomegranate
end

function personal_env
  clear_env
  set -gx AWS_PROFILE personal
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

function today -d "Open today's notes"
  set -l todays_date (date +%F)
  set -l notes_directory "$HOME/Notes/$todays_date"
  set -l note_file "$notes_directory/today.md"
  set -l template_file "$HOME/Notes/templates/today.md"

  install_notes

  if not test -e $note_file
    mkdir -p $notes_directory
    cp $template_file $note_file

    if [ (uname) = "Darwin" ]
      sed -i '' "s/TodaysDate/$todays_date/" $note_file
    else
      sed -i "s/TodaysDate/$todays_date/" $note_file
    end
  end

  pushd $notes_directory
  vim $note_file
  popd
end

function standup -d "Open today's standup notes"
  set -l todays_date (date +%F)
  set -l notes_directory "$HOME/Notes/$todays_date"
  set -l note_file "$notes_directory/standup.md"
  set -l template_file "$HOME/Notes/templates/standup.md"

  install_notes

  if not test -e $note_file
    mkdir -p $notes_directory
    cp $template_file $note_file

    if [ (uname) = "Darwin" ]
      sed -i '' "s/TodaysDate/$todays_date/" $note_file
    else
      sed -i "s/TodaysDate/$todays_date/" $note_file
    end
  end

  pushd $notes_directory
  vim $note_file
  popd
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

function cf_ssh
  set -l app (apps | fzf)

  cf ssh $app -t -c "export PATH='/bin/:/usr/local/bin:/usr/bin'; cd /app; /bin/sh"
end

function cf_rb
  set -l app (apps | grep -e frontend -e backend -e admin -e duty -e signon | fzf)

  cf ssh $app -t -c "export PATH='/bin/:/usr/local/bin:/usr/bin'; cd /app; /usr/local/bin/bundle exec rails c"
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

function cf_info
  set -l service (services | grep redis | fzf)

  cf conduit $service -- redis-cli info
end

function cf_psql
  set -l service (services | grep postgres | fzf)

  cf conduit $service -- psql
end

function backup_manifests
  cdr; cd hmrc/manifests-backup

  for space in (cat spaces)
    cf target -s $space
    mkdir -p $space/

    pushd $space

    apps > apps

    for app in (cat apps)
      cf create-app-manifest $app
    end

    popd
  end
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
  set -l url $argv[1]
  set -l repo $argv[2]
  set -l sha1 (curl --silent $url | jq '.git_sha1' | tr -d '"') 
  set -l repo_dir $HOME/Repositories/hmrc/$repo

  pushd $repo_dir
  # git clean -df; git checkout -- .; git cm
  echo $repo
  echo
  echo $sha1
  echo
  git log --merges HEAD...$sha1 | grep -A 2 'Merge ' | grep -v '\-\-' | grep -v 'Merge' | awk '{$1=$1};1' | awk '!/^$/' | awk '{print "- "$0}' # | sed -r 's/^- (.*)([-|\s])([0-9]*)/- HOTT-\3:/'
  echo
  popd
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
