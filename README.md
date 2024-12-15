# Dotfiles 

Stowed away dotfiles ready for use at a moments notice. 

# Installation  

This uses [GNU Stow](https://www.gnu.org/software/stow) so make sure you have that installed. 

Then just link packages that you want to use. 

```bash
stow -t ~ <package>
```

Example:

```bash
stow -t ~ vim
```

If you want to link a package from a namespace then you can do it like this:

```bash
stow -d terminals -t ~ wezterm
```


