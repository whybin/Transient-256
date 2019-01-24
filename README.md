# Transient

Dark Vim color scheme designed for xterm-256color (with gui equivalents).

**Vim**
![Haskell in
Vim](https://raw.githubusercontent.com/whybin/files/master/transient-haskell.png)

**Neovim**
![Rust in
Neovim](https://raw.githubusercontent.com/whybin/files/master/transient-rust-nvim.png)

**MacVim**
![Python in
MacVim](https://raw.githubusercontent.com/whybin/files/master/transient-python-macvim.png)

## Use

Set your color scheme by adding the line `colorscheme transient` to your `.vimrc`

## Additional Settings

Modify highlighting for additional groups by adding to your `.vimrc`

[vim-gitgutter](https://github.com/airblade/vim-gitgutter)

    hi! link GitGutterAdd DiffAdd
    hi! link GitGutterChange DiffChange
    hi! link GitGutterDelete DiffDelete
