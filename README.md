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

## TODO
set myip alias
set trash alias

