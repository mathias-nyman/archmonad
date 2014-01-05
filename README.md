Overview
===
This is a custom archiso which contains blackarch (http://www.blackarch.org/) and other goodies.
Dotfiles from https://github.com/mathias-nyman/dotfiles make up the core of the desktop enviornment.

Build
===
The following addition is needed in /etc/pacman.conf on the build machine:

    [blackarch]
    SigLevel = Optional TrustAll
    Server = http://blackarch.org/blackarch/$repo/os/$arch

