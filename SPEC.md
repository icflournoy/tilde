# Linux Workstation Specification

## Software

### User Software

- alacritty
- awscli
- docker
- feh
- gcloud/gsutil
- i3-gaps (or sway?)
- gitg
- mosh
- nvm/node/npm
- slack
- terraform
- ripgrep
- httpie
- jq
- jo (COPR)
- json2yaml (custom script)
- terraform
- wireguard-tools

## shell extensions

- fzf
- eternal history
- dircolors
- bash-repo-completion
- gitprompt
- remote/local prompt color
- root prompt colors
- editing mode

## Behaviors

- Wallpaper rotation
- Automatic screenshot archival
- Automatic purge of Downloads
- Disable boot splash

---

## Resolve

- Mixed-DPI environment not possible with X-Server (i3 WM)
- Using Wayland (Sway WM) very alpha (and they don't like NVidia graphics)

## VS Code

- `https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc`

## gcloud setup

- application default credentials

## Docker/moby-engine
- disable cgroups v2
- specifically for aerospike container:
  - systemd hard nofile limit in /etc/systemd/system.conf.d/ (DefaultLimitNOFILE)
  - systemd soft nofile limit in /etc/systemd/user.conf.d/ (DefaultLimitNOFILE)
  - /etc/security/limits.conf
  - https://unix.stackexchange.com/a/443467

## nvm setup
- add nvm to bashrc
- npm login

