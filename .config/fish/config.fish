if status is-interactive
    # Commands to run in interactive sessions can go here
  starship init fish | source
  direnv hook fish   | source
  zoxide init fish | source
end

# Colors
# set -l teal 94e2d5
# set -l flamingo f2cdcd
# set -l mauve cba6f7
# set -l pink f5c2e7
# set -l red f38ba8
# set -l peach fab387
# set -l green a6e3a1
# set -l yellow f9e2af
# set -l blue 89b4fa
# set -l gray 1f1d2e
# set -l black 191724

# Completion Pager Colors
set -g fish_pager_color_progress $gray
set -g fish_pager_color_prefix $mauve
set -g fish_pager_color_completion $peach
set -g fish_pager_color_description $gray

# Dont show greeting 
set -g fish_greeting

# Git config
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_cleanstate '✔'
set -g __fish_git_prompt_char_dirtystate '✚'
set -g __fish_git_prompt_char_invalidstate '✖'
set -g __fish_git_prompt_char_stagedstate '●'
set -g __fish_git_prompt_char_stashstate '⚑'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_upstream_ahead ''
set -g __fish_git_prompt_char_upstream_behind ''
set -g __fish_git_prompt_char_upstream_diverged 'ﱟ'
set -g __fish_git_prompt_char_upstream_equal ''
set -g __fish_git_prompt_char_upstream_prefix ''''


set -g man_blink -o $teal
set -g man_bold -o $pink
set -g man_standout -b $gray
set -g man_underline -u $blue

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Exports
export VISUAL="nvim"
export EDITOR="$VISUAL"

# Term
switch "$TERM_EMULATOR"
case '*kitty*'
	export TERM='xterm-kitty'
case '*'
	export TERM='xterm-256color'
end

# Abbrevations
abbr -a -g d 'dirs'
abbr -a -g c 'clear'
abbr -a -g h 'history'
abbr -a -g upd 'paru -Syu --noconfirm'
abbr -a -g untar 'tar -zxvf'
abbr -a -g genpass 'openssl rand -base64 20'
abbr -a -g sha 'shasum -a 256'
abbr -a -g cn 'ping -c 5 8.8.8.8'
abbr -a -g ipe 'curl ifconfig.co'
abbr -a -g ips 'ip link show'
abbr -a -g wloff 'rfkill block wlan'
abbr -a -g wlon 'rfkill unblock wlan'

abbr -a -g ls 'exa -al --color=always --group-directories-first'
abbr -a -g la 'exa -a --color=always --group-directories-first'  # all files and dirs
abbr -a -g ll 'exa -l --color=always --group-directories-first'  # long format
abbr -a -g lt 'exa -aT --color=always --group-directories-first' # tree listing

# start vlc using the web cam
abbr -a -g vlcme 'cvlc v4l2:// :input-slave=alsa:// :v4l-vdev="/dev/video0"'
abbr -a -g vi 'nvim'
abbr -a -g vim 'nvim'

abbr -a -g colorselect 'gcolor2'
abbr -a -g print-key "xev -event keyboard | egrep -o 'keycode.*\)'"

abbr -a -g df 'df -h'                          # human-readable sizes
abbr -a -g free 'free -m'                      # show sizes in MB

abbr -a -g cpgl "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# broot
abbr -a -g br 'broot -dhp'
abbr -a -g bs 'broot --sizes'

abbr -a -g cpcurl 'curl -H "Content-Type: application/json" -H "cp-axa-user-id: CP-ADMIN-USER" -H "cp-axa-user-role: ADMIN" '

abbr -a -g dotfiles "/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"


# Source plugins
# Useful plugins: archlinux bang-bang cd colorman sudope vcs
if test -d "$HOME/.local/share/omf/pkg/colorman/"
	source ~/.local/share/omf/pkg/colorman/init.fish
end

# Make su launch fish
function su
   command su --shell=/usr/bin/fish $argv
end

# use vi keybindings
fish_vi_key_bindings

set PATH $PATH /home/dan/.local/bin

