# my personal config file

- neovim
- zsh
- tmux
- mpv
- niri with dms
- keyd
- aria2
- zathura
```bash
sudo pacman -Sy neovim zsh tmux mpv aria2 zathura keyd
```

## Installation

- manage dotfiles with chezmoi
```bash
cd ~
git clone https://github.com/integer2bit/dotfiles
cd dotfiles
chezmoi apply
```

## font

- ttf-jetbrains-mono
- ttf-jetbrains-mono-nerd
- noto-fonts-cjk


## tmux

### Install config

Run `tmux source .tmux.conf` and press \<prefix\>I Install tmux plugins in tmux sessions

- prefix set \<C-Space\>
- \<prefix\>r reload tmux config

## zsh 
- dependencies: [fzf](https://github.com/junegunn/fzf)
- Installation
  - source .zshrc
  - excute `chsh -s $(which zsh)`


## neovim plugins dependencies

- tools
```bash
sudo pacman -Sy ripgrep fd fzf git wget unzip gzip nodejs npm python python-pip clang make cmake tree-sitter-cli texlive
```

- Language server and formatter
```bash
sudo pacman -Sy bash-language-server typescript-language-server vscode-html-languageserver vscode-json-languageserver vscode-css-languageserver yaml-language-server lua-language-server marksman prettier shfmt stylua ruff
```

## window manager
#### dependencies and tools
- swayidle
- dms
- quickshell
- rofi
- rofi-emoji
- thunar (xfce4 file manager), gvfs gvfs-dnssd (trashbin and webdav support) 
```bash
sudo pacman -Sy niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk dms-shell-niri matugen cava qt6-multimedia-ffmpeg swayidle wl-clipboard
systemctl --user add-wants niri.service dms
```

## mpv

### Plugins
- autoload (official)
- [recent](https://github.com/hacel/recent)
  hotkeys:`CTRL+r`
- [thumbfast](https://github.com/po5/thumbfast/tree/master)
- [osc-mordern-f](https://github.com/FinnRaze/mpv-osc-modern-f) 
- ytdl_hook [reference](https://github.com/hooke007/MPV_lazy/blob/main/portable_config/script-opts/ytdl_hook.conf)
### play stram vedio with Tampermonkey plugins
[Play with mpv](https://github.com/LuckyPuppy514/Play-With-MPV)
