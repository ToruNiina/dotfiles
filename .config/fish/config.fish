set -gx EDITOR nvim

# ============================================================================
# path

set fish_user_paths
set fish_user_paths /opt/nvim/bin/          $fish_user_paths
set fish_user_paths /home/niina/.local/bin/ $fish_user_paths
set fish_user_paths /home/niina/.cargo/bin/ $fish_user_paths

set -x COLORTERM truecolor

# ============================================================================
# command alias

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias vim='nvim'
alias vimdiff='nvim -d'
alias view='nvim -R'

# typo is a human error. it inevitably occurs. machine must guess my intention.
alias l='ls -CFh'
alias la='ls -A'
alias ll='ls -alFh'
alias lc='ls'
alias sl='ls'
alias ks='ls'
alias kls='ls'
alias sls='ls'
alias lsr='ls'
alias lls='ls'

alias mak='make'
alias maek='make'
alias mamke='make'
alias amke='make'
alias amek='make'

alias scd='cd'
alias cdi='cd'

alias gt='git'
alias gi='git'
alias gti='git'
alias igt='git'
alias gitstatus='git status'

function getpdb
	wget "http://www.rcsb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=$argv[1]" -O $argv[1].pdb;
end

# ============================================================================
# Color

# commandline
set fish_color_normal         brwhite
set fish_color_autosuggestion brgrey
set fish_color_cancel         brcyan
set fish_color_command        bryellow
set fish_color_comment        brblack
set fish_color_cwd            brred
set fish_color_end            brwhite
set fish_color_error          brred
set fish_color_escape         brcyan
set fish_color_host           brgreen
set fish_color_host_remote    bryellow
set fish_color_match          brcyan --underline
set fish_color_operator       brpurple
set fish_color_param          bryellow
set fish_color_quote          brgreen
set fish_color_redirection    brcyan
set fish_color_search_match   --background=brblack
set fish_color_selection      --background=brblack
set fish_color_user           brblue

# pager
set fish_pager_color_progress              brblack --italics
set fish_pager_color_secondary_background  # null
set fish_pager_color_secondary_completion  brblack
set fish_pager_color_secondary_description brblack
set fish_pager_color_secondary_prefix      brblack
set fish_pager_color_selected_background   --background=brblack
set fish_pager_color_selected_completion   bryellow
set fish_pager_color_selected_description  bryellow
set fish_pager_color_selected_prefix       bryellow
