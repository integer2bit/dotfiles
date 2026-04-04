# My personal config file

- neovim(in ArchLinux)
- tmux
- aria2
- zsh
- mpv
- i3(x11)
- sway(wayland)
- zathura(pdf viewer, with zathura-pdf-mupdf)

## Installation 

```bash
cd ~
git clone https://github.com/integer2bit/dotfiles
cd dotfiles
stow -t ~ */
```
If you have config file exists, there may some erros. Backup your original files and remove them. Then try `stow -t ~ */` again.

Or you can also stow single directory like stow zsh, this will only link the contain package data.

## font

- ttf-jetbrains-mono
- ttf-jetbrains-mono-nerd
- noto-fonts-cjk

## tmux

### Install config

Run `tmux source .tmux.conf` and press \<prefix\>I Install tmux plugins in tmux sessions

- prefix set \<C-Space\>
- \<prefix\>r reload tmux config

## zsh dependencies

- [fzf](https://github.com/junegunn/fzf)

### Installation

1. copy .zshrc to $HOME
2. source .zshrc
3. excute `chsh -s $(which zsh)`

## neovim plugins dependencies

- [ripgrep](https://github.com/BurntSushi/ripgrep),[fd](https://github.com/sharkdp/fd), [fzf](https://github.com/junegunn/fzf), git, wget, unzip, gzip, nodejs, npm, python3, python-pip, clang, make, cmake, texlive, (for vimtex), tree-sitter-cli, (for latex parser)

- Language server and formatter(ArchLinuxRepo)
  - bash-language-server
  - typescript-language-server
  - vscode-html-languageserver
  - vscode-json-languageserver
  - vscode-css-languageserver
  - yaml-language-server
  - lua-language-server
  - marksman
  - prettier
  - shfmt
  - stylua
  - ruff

## window manager
### [sway](https://github.com/swaywm/sway)(main)
#### dependencies and tools
- sway swaybg swayidle swaylock
- dependencies
  - meson wlroots0.18 wlroots0.19 wayland wayland-protocols pcre2 json-c pango cairo xorg-xwayland
- kitty (terminal)
- rofi (app launcher)
- rofi-emoji
- waybar (status bar)
- swayimg(imgvivwer)
- grim(screenshot)
- slurp(screenshot)
- brightnessctl(brightness control)
- thunar (xfce4 file manager), gvfs gvfs-dnssd (trashbin and webdav support) 

### i3(optional)
#### dependencies and tools
- dependencies
  - i3 xorg-server xorg-xinit 
- kitty (terminal)
- picom(compositor)
- rofi (app launcher)
- rofi-emoji (xdotool, xclip needed)
- feh(wallpaper)
- imagemagic(i3lock)
- thunar (xfce4 file manager), gvfs gvfs-dnssd (trashbin and webdav support) 
- maim (screenshot)
- copyq (multi-media clipboard)
- pavucontrol(audio control)
- acpilight (xbacklight excutable provided)

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
