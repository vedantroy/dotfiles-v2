# Ubuntu-Gnome-I3 Config

## Principles:
- Prefer less applications rather than more
    - E.g using gnome-terminal > kitty
    - But install applications necessary for any functionality + basic aesthetics
    	- E.g picom for transparency / shadows, but not kitty for font ligatures
- Don't try to create an all-in-one install script (too fragile). The human is the installer.
  Just leave guidelines for the human.
  - Basic install scripts for sets of commands is fine

## Dependencies
- https://github.com/deuill/i3-gnome-flashback
  - Use i3-gaps
  - Allows brightness, volume control, bluetooth, all of Gnome's utilities!?
- https://github.com/Mayccoll/Gogh
  - Run this to make gnome-terminal use gruvbox
  - Afterwards, right click (in terminal window) -> Preferences -> (Set Gruvbox as default profile)

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