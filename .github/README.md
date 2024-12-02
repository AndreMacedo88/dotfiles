# Purpose

# Managing the dotfiles

## Initial setup

Create a bare repository to store the history:

```bash
git init --bare $HOME/dotfiles
```

Create an alias in your shell, tell Git where the history and the working tree live:

```bash
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Set up the remote repository for syncing:

```bash
dot remote add origin https://<githubtoken>@github.com/<username>/dotfiles.git
dot branch -M main
```

Tell Git not to show all the untracked files, otherwise all files under `$HOME` will be shown when running `dot status`:

```bash
dot config status.showUntrackedFiles no
```

Done! Now we can manage our dotfiles.

```bash
dot status
dot add <path-to-your-file/s>
dot commit -m "initial dotfiles commit"
dot push origin main
```

## Clone to another machine

Clone the dotfiles into a bare repository:

```bash
git clone --bare https://<username>:<githubtoken>@github.com/<username>/dotfiles.git $HOME/dotfiles
```

Define the alias in the current shell scope:

```bash
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Backup the stock configuration files that will be overwritten (example for config dir):

```bash
mkdir -p .config-backup
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
```

Checkout the actual content from the bare repository to `$HOME`:

```bash
dot checkout
```

Don't show untracked files and directories:

```bash
dot config status.showUntrackedFiles no
```

Done!

## Notes:
- In case some tool/plugin requires this to not be a bare repository, do the following:

```bash
dot config core.bare 'false'
dot config core.worktree "$HOME"
```

- This Managing section was adapted from https://github.com/rockyzhang24/dotfiles
