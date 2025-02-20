TODO

 export GITHUB_USERNAME=abstracts33d && curl -sfL https://raw.githubusercontent.com/$GITHUB_USERNAME/dotfiles/main/.startup.sh | bash


sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

Collect tools to auto install
  in arch like pkg-list and yay
  in macos Brewfile

doccument this readme

list repositories to be cloned like tpm or fzf-tab

fix keyboard settings in Arch
  gsettings list-recursively | grep '<Super>'
  gsettings set org.gnome.shell.keybindings toggle-quick-settings '["disabled"]'
  gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '["disabled"]'
  gsettings set org.gnome.shell.keybindings focus-active-notification '["disabled"]'


Implement mod layer in karabiner-elements


TODO
  imporve dot_other_places (might be another way) (ATM only sshd config )

SETUP WOL ON KRACH
```
  sudo nmcli con show
  nmcli c modify "Wired connection 2" 802-3-ethernet.wake-on-lan magic
```

Save Karabiner elements rules
Save keyboard shortcuts for linux (find more declarative wm)

compact 3rfan dotfiles in a .md  to setup arm64 arch inside UTM
https://github.com/3rfaan/dotfiles
