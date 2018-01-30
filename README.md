Dotfiles Configuration

My dotfiles configuration uses a bare git repo. This allows the user home
directory to keep files in their respective locations without the need for
linking.

With this power comes responsibility. NEVER BLANKET ADD `hsscfg add .`

# How to setup on a new machine
cd $HOME

git init --bare $HOME/.hsscfg

alias hsscfg='/usr/bin/git --git-dir=$HOME/.hsscfg/ --work-tree=$HOME'

hsscfg config --local status.showUntrackedFiles no

echo "alias hsscfg='/usr/bin/git --git-dir=$HOME/.hsscfg/ --work-tree=$HOME'" >> $HOME/.bashrc

hsscfg remote add origin https://github.com/evanharmon/dotfiles.git

## TODO
### ZSH
- can't search history with fzf rg
- add alias alias ava='nocorrect ava'
- fix AWS completions
```
AWS
unamestr=`uname`
Assume Linux if not Darwin
if [[ $unamestr == 'Darwin' ]]
then
# source /usr/local/bin/aws_zsh_completer.sh
else
# source /usr/bin/aws_zsh_completer.sh
fi
```
- fix tab error `_vim_files: function definition file not found`
- fix errors `_git:58: _git_commands: function definition file not found
_git:58: _git_commands: function definition file not found
_git:58: _git_commands: function definition file not found`
