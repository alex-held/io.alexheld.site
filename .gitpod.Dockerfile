FROM gitpod/workspace-full

USER root
RUN sudo apt-get update && \
    sudo apt-get install -y

USER gitpod
RUN brew install fzf
RUN brew install remotemobprogramming/brew/mob
RUN brew install hugo

USER gitpod
