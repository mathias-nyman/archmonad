Overview
===
This is a custom archiso which contains blackarch (http://www.blackarch.org/) and other goodies.
Dotfiles from https://github.com/mathias-nyman/dotfiles make up the core of the desktop enviornment.

Build
===
Some 30gb of disk space is needed for the build.
The following addition is needed in /etc/pacman.conf on the build machine:

    [blackarch]
    SigLevel = Optional TrustAll
    Server = http://blackarch.org/blackarch/$repo/os/$arch

Need to know
===
Need to know:
* User *root* has password *root*
* A normal user, *arch* exists, but has no password - so can't log in
* An ssh server runs on port 22, but denies log in with *root*

So the first thing to do is log in as *root* at console and set a password for *arch* and remove the password for *root*, to even disable console log in for *root*.

Dependencies
===
Archiso
