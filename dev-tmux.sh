#!/bin/bash
tmux new-session -d 'vim'
tmux new-window 'bash'
tmux split-window -v
tmux -2 attach-session -d
