Overview
===
This is a custom archiso which contains blackarch (http://www.blackarch.org/).

Build
===
The following addition is needed in /etc/pacman.conf on the build machine:

    [blackarch]
    SigLevel = Optional TrustAll
    Server = http://blackarch.org/blackarch/$repo/os/$arch

