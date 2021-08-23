# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
function fzl() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-s:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"\
      --bind "ctrl-c:abort+execute:
                (grep -o '[a-f0-9]\{7\}' | tr '\n' '\0' |
                 xclip) << 'FZF-EOF'
                {}
FZF-EOF"\
      --bind "ctrl-R:execute:
                (grep -o '[a-f0-9]\{7\}' | tr '\n' '\0' |
                xargs --null -I % sh -c 'git rebase -i %~1') << 'FZF-EOF'
                {}
FZF-EOF"\
      --bind "ctrl-r:abort+execute:
                (grep -o '[a-f0-9]\{7\}' | tr '\n' '\0' |
                xargs --null -I % sh -c 'echo git rebase -i %~1' | tr '\n' '\0' | xclip) << 'FZF-EOF'
		{}
FZF-EOF"
}

