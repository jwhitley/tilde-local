# Terminal setup

`xterm-256color.ti` contains fixes for italics support in tmux, and
backspace semantics on OS X terminals.  See [this comment on
neovim/neovim#2048][1] for details.

[1]: https://github.com/neovim/neovim/issues/2048#issuecomment-78045837

`tmux-256color.ti` includes the backspace fix and adds changes per the tmux FAQ
(as of version 2.1) to properly display italics.

These files updated July 2020 using the terminfo files from [this comment on
tmux/tmux#1257][2] to get italics support working properly under tmux.

[2]: https://github.com/tmux/tmux/issues/1257#issuecomment-365774651

## Usage

```
tic ~/local/doc/xterm-256color.ti
tic -x ~/local/doc/tmux-256color.ti
```
