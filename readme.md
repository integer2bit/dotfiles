# My personal config file

- neovim(in ArchLinux)
  - intergrate with obsidian
- tmux
- aria2
- zsh
- mpv
- i3(with i3status)
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

### dependencies

- xclip for tmux yank and clipboard

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

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- git
- curl or wget
- unzip
- gzip
- nodejs
- npm
- python3
- python-pip
- gcc
- make
- cmake
- texlive (for vimtex)
- tree-sitter-cli (for latex parser)

## i3
### dependencies and tools

- picom(compositor)
- feh(wallpaper)
- xorg(xorg-xrandr and xorg config)
- pavucontrol(audio control)
- rofi (app launcher)
- rofi-emoji (xdotool, xclip needed)
- i3lock-fancy(better lock style)
- acpilight (xbacklight excutable provided)
- spectacle (screenshot)
- kitty (terminal)
- network-manager-applet (wireless tray)
- fcitx5 (input method)
- nautilus (gnome file manager)

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
