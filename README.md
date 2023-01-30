# Installing CDE (Common Desktop Environment)



[Raspberry Pi install](https://sourceforge.net/p/cdesktopenv/wiki/CDE%20on%20the%20Raspberry%20Pi/)
[Ubuntu / Debian install](https://sourceforge.net/p/cdesktopenv/wiki/LinuxBuild/)
## Preprocess

Before downloading and compiling, you need to do the following steps:

Localization:

```sh
sudo locale-gen de_DE
sudo locale-gen es_ES
sudo locale-gen fr_FR
sudo locale-gen it_IT
sudo locale-gen de_DE.UTF-8
sudo locale-gen es_ES.UTF-8
sudo locale-gen fr_FR.UTF-8
sudo locale-gen it_IT.UTF-8
```

```sh
apt-get -y install \
    autoconf \
    automake \
    bison \
    build-essential \
    flex
    g++ \
    git \
    ksh \
    libtool \
    lib{xt,xmu,xft,xinerama,xpm,pam,motif,ssl,xaw7,x11,xss,tirpc,jpeg,freetype6,utempter}-dev \
    m4 \
    ncompress \
    patch \
    rpcbind \
    tcl-dev \
    x11proto-fonts-dev \
    xbitmaps \
    xfonts-{100,75}dpi{,-transcoded} \
    xorg \
```
