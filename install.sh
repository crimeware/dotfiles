#!/bin/bash

echo -n  "Install dotfiles? (N/y): "
read RUN
echo

if [[ $RUN == "y" ]]
then
  echo "Starting..."
  echo
else
  echo "Stopping..."
  echo
  exit 1
fi

# Check for dependencies
if ! command -v rsync --version &> /dev/null
then
    echo "Error:"
    echo "    'rsync' could not be found."
    echo "    'rsync' is required in order to backup your current configs."
    echo "    Install 'rsync' with your package manager before running the script."
    exit 1
fi

if ! command -v stow --version &> /dev/null
then
    echo "Error:"
    echo "    'stow' could not be found."
    echo "    'stow' is required in order to create symlinks for installation."
    echo "    Install 'stow' with your package manager before running the script."
    exit 1
fi

# Check for existance of previous backup
if [ -d "bak" ] 
then
    echo
    echo "Error:"
    echo "    Directory 'bak' already exists."
    echo "    Installation canceled as a safety measure."
    echo "    Review the contents of 'bak' and make sure you don't need it."
    echo "    Then delete it and run the process again."
    exit 2
fi

# Make a backup of current system
echo -n "Backing up files into the 'bak' directory... "
rsync -aRL --delete ~/.config/hypr bak/
rsync -aRL --delete ~/.config/waybar bak/
rsync -aRL --delete ~/.config/kitty bak/
rsync -aRL --delete ~/.config/bottom bak/
rsync -aRL --delete ~/.config/dunst bak/
rsync -aRL --delete ~/.config/cava bak/
rsync -aRL --delete ~/.config/wofi bak/
rsync -aRL --delete ~/.config/neofetch bak/
rsync -aRL --delete ~/.swaylock bak/
rsync -aRL --delete ~/.p10k.zsh bak/
rsync -aRL --delete ~/.zshrc bak/
rsync -aRL --delete ~/.zshenv bak/
echo "Done"

echo
echo "In case something goes wrong your original configs were copied to a folder called 'bak' in the current directory."
echo
echo -n "Continue? (N/y): "
read CONTINUE
echo

if [[ $CONTINUE == "y" ]]
then
  echo "Installing..."
  echo
else
  echo "Stopping..."
  echo
  exit 1
fi

# Install configs
echo -n "Installing hyprland configs... "
rm -rf ~/.config/hypr
stow hyprland
echo "Done"

echo -n "Installing waybar configs... "
rm -rf ~/.config/waybar
stow waybar
echo "Done"

echo -n "Installing kitty configs... "
rm -rf ~/.config/kitty
stow kitty
echo "Done"

echo -n "Installing bottom configs... "
rm -rf ~/.config/bottom
stow bottom
echo "Done"

echo -n "Installing dunst configs... "
rm -rf ~/.config/dunst
stow dunst
echo "Done"

echo -n "Installing cava configs... "
rm -rf ~/.config/cava
stow cava
echo "Done"

echo -n "Installing wofi configs... "
rm -rf ~/.config/wofi
stow wofi
echo "Done"

echo -n "Installing neofetch configs... "
rm -rf ~/.config/neofetch
stow neofetch
echo "Done"

echo -n "Installing swaylock configs... "
rm -rf ~/.swaylock
stow swaylock
echo "Done"

echo -n "Installing zsh configs... "
rm -rf ~/.p10k.zsh
rm -rf ~/.zshrc
rm -rf ~/.zshenv
stow zsh
echo "Done"

echo
echo "The installation was successful. Have fun!"

exit 0