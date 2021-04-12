# Ubuntu-Gnome-I3 Config

## Principles:
- Prefer less applications rather than more
    - More applications cause setups to degrade overtime (even if they look nicer/are initially faster). The fastest optimization is deletion.
    - E.g using gnome-terminal > kitty
    - E.g not using powerlevel10k
    - But install applications necessary for any functionality + basic aesthetics
    	- E.g picom for transparency / shadows, but not kitty for font ligatures
- Don't try to create an all-in-one install script (too fragile). The human is the installer.
  Just leave guidelines for the human.
  - Basic install scripts for sets of commands is fine

## Some Dependencies
- https://github.com/deuill/i3-gnome-flashback
  - Use i3-gaps
  - Allows brightness, volume control, bluetooth, all of Gnome's utilities!?
- https://github.com/Mayccoll/Gogh
  - Run this to make gnome-terminal use gruvbox
  - Afterwards, right click (in terminal window) -> Preferences -> (Set Gruvbox as default profile)
  - [May fix error](https://github.com/Mayccoll/Gogh/issues/203)

### i3 aux
- rofi
- i3blocks
- feh
  - background image
- ~~yad, xdotool~~
  - i3blocks calendar popup
  - Currently broken
- xclip
  - neovim copy/paste (see :help clipboard in Neovim)
- [nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
  - Run `./install.sh Hack`

## Random Commands
- `chsh -s $(which zsh)` to make zsh default shell

## Quirks
- I have included versions of the zsh plugins in this repo (instead of cloning them).
  This means their versions are frozen unless I manually update. This seems fine
  since I never previously manually updated.
- You might need to disable the header bar for Gnome terminal with `gsettings set org.gnome.Terminal.Legacy.Settings headerbar false`
  - Close all terminals afterwards to make changes take effect	
  - Disable the menu bar with a right-click on it + "Don't show" (or whatever the option is)
- Also disable the menubar by in Gnome terminal's general preferences
- When installing Python, asdf compiles it from source?! So follow [this guide](https://github.com/pyenv/pyenv/wiki/Common-build-problems)
