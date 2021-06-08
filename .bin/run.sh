echo ".dotfile" >> .gitignore
git clone --bare  https://github.com/lufarP/dotfile.git $HOME/.dotfile
function dotfile {
   /usr/bin/git --git-dir=$HOME/.dotfile/ --work-tree=$HOME $@
}
mkdir -p $HOME/.dotfile-backup
dotfile checkout
if [ $? = 0 ]; then
  echo "Checked out dotfile.";
  else
    echo "Backing up pre-existing dot files.";
    dotfile checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfile-backup/{}
fi;
dotfile checkout
dotfile config status.showUntrackedFiles no

