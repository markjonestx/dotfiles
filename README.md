# My Personal Dotfiles

## Installing Software
Use the `-e "install_sofrware=true"` to have the playbook install the software
required for everything to work. Requires the user to have standard password
based sudo. No 2FA.

## Deploy to only the current host
Use the `-i localhost, -c local` to deploy to the local machine without using
SSH.

## Playbooks
- shell.yml: This will only install CLI configurations. Stuff like nvim, vim
  tmux, and zsh.
- desktop.yml: This will do everything shell.yml does, but also includes
  configuration for i3, rofi, and other tools required for a full desktop
  workstation.

