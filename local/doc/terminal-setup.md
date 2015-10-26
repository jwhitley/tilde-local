# Terminal setup

`screen-256color.ti` and `xterm-256color.ti` contain fixes for backspace
semantics, particularly on OS X terminals.  See [this comment on
neovim/neovim#2048][1] for details.

[1]: https://github.com/neovim/neovim/issues/2048#issuecomment-78045837

`tmux-256color.ti` includes the backspace fix and adds changes per the tmux FAQ
(as of version 2.1) to properly display italics.

## Usage

```
tic ~/local/doc/screen-256color.ti
tic ~/local/doc/xterm-256color.ti
tic -x ~/local/doc/tmux-256color.ti
```
