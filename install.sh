#!/usr/bin/env bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

echo "${BOLD}Note: git, nvim and zsh are required."

failed=false
packages=( git vim zsh )
for package in "${packages[@]}"
do
    command -v ${package} >/dev/null 2>&1 || { echo "${RED}${package} is missing."; failed=true; }
done

if ${failed} == true; then
    echo "${NORMAL}Please ensure you have all required packages installed. i.e.:"
    echo "${YELLOW}${BOLD}Arch: ${NORMAL}sudo pacman -S git nvim zsh"
    echo "After doing so, re-run this script."
    exit 1
fi

git clone git://github.com/andsens/homeshick.git ${HOME}/.homesick/repos/homeshick
${HOME}/.homesick/repos/homeshick/bin/homeshick clone -b git@github.com:stephenfairchild/Dotfiles.git

${HOME}/.homesick/repos/homeshick/bin/homeshick link -b

echo "${GREEN}${BOLD}Installation complete! You can now run \`sudo chsh -s /bin/zsh $(whoami)\` to set zsh as your default shell."
echo "${NORMAL}"
