Overview
===
This is a custom archiso which contains XMonad and other goodies.
Dotfiles from https://github.com/mathias-nyman/dotfiles make up the core of the "desktop enviornment".

Good to know
===
Need to know:
* User *root* has password *root*
* A normal user, *arch* exists, but has no password - so can't log in
* An ssh server runs on port 22, but denies log in with *root*

So the first thing to do is log in as *root* at console and set a password for *arch* and remove the password for *root*, to even disable console log in for *root*.

Buidling
===
You will need an Arch Linux system with at least *archiso* package installed.
