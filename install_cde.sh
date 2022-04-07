#!/bin/bash

# References:
#
# - Install on Ubuntu/Debian
# https://sourceforge.net/p/cdesktopenv/wiki/LinuxBuild/#debian
#
# - Raspberry Pi (Contains errors, fixed in this script)
# https://sourceforge.net/p/cdesktopenv/wiki/CDE%20on%20the%20Raspberry%20Pi/
#
# - Improve fonts
# https://sourceforge.net/p/cdesktopenv/wiki/ImprovingFonts/
# http://futurile.net/2016/06/14/xterm-setup-and-truetype-font-configuration/
# 
# - Motif look and feel for GTK apps
# https://www.pling.com/s/Gnome/p/1231025
# 
# Additional software
# https://snapcraft.io/install/xv/raspbian
# 

# >>> NOTE: Keyboard layout <<<
# If you have a non-english keyboard layout, add an X11 configuration file. See 
# https://sourceforge.net/p/cdesktopenv/wiki/CDE%20on%20the%20Raspberry%20Pi/ 
# section 3 for more info.


function preprocess {
    #------------------------------------------------------------------------------ 
    # Generate locale support
    #------------------------------------------------------------------------------ 
    sudo locale-gen de_DE
    sudo locale-gen es_ES
    sudo locale-gen fr_FR
    sudo locale-gen it_IT
    sudo locale-gen de_DE.UTF-8
    sudo locale-gen es_ES.UTF-8
    sudo locale-gen fr_FR.UTF-8
    sudo locale-gen it_IT.UTF-8

    #------------------------------------------------------------------------------ 
    # Install needed packages
    #------------------------------------------------------------------------------ 
    sudo apt-get -y install \
        autoconf \
        automake \
        bison \
        build-essential \
        flex \
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
        xorg 
}


function install_cde {
    #------------------------------------------------------------------------------ 
    # Compile and install CDE
    #------------------------------------------------------------------------------ 
    pushd /tmp

    git clone https://git.code.sf.net/p/cdesktopenv/code cdesktopenv-code
    cd cdesktopenv-code/cde

    ./autogen.sh
    ./configure
    make -j4
    sudo make install

    popd
}

function set_display_manager {
    #------------------------------------------------------------------------------ 
    # Set default display manager 
    # WIP: dtlogin is not working properly after reboot.
    #------------------------------------------------------------------------------ 
    sudo mv /etc/X11/default-display-manager /etc/X11/default-display-manager.bu
    sudo echo "/usr/dt/bin/dtlogin" > /etc/X11/default-display-manager
    sudo cp ./resources/systemd/dtlogin.service /lib/systemd/system/dtlogin.service
    sudo ln -svf /lib/systemd/system/dtlogin.service /etc/systemd/system/display-manager.service
    sudo ln -svf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
}

function improve_fonts {
    #------------------------------------------------------------------------------ 
    # Improve fonts of the interface
    #------------------------------------------------------------------------------ 
    sudo apt install gsfonts gsfonts-x11 ttf-mscorefonts-installer fonts-powerline
    sudo mv /usr/dt/config/xfonts/C/fonts.alias /usr/dt/config/xfonts/C/fonts.alias.bu
    sudo cp ./resources/fonts/fonts.alias /usr/dt/config/xfonts/C/fonts.alias
}

#------------------------------------------------------------------------------ 
# Add Motif theme for GTK
#------------------------------------------------------------------------------ 
function set_motif_lookandfeel {
    mkdir -p ${HOME}/.themes
    tar -C ${HOME}/.themes/ zxvf ./resources/gtk/cdetheme1.3.tar.gz 
    ln -s ${HOME}/.themes/cdetheme1.3/cdetheme ${HOME}/.themes/cdetheme
    cp ./resources/gtk/settings.ini ${HOME}/.config/gtk-3.0/
}

function add_additional_software {
    #------------------------------------------------------------------------------ 
    # Install some additional X11 software from the mid 90s era.
    #------------------------------------------------------------------------------ 
    sudo apt install -y \
        xfig \
        xpdf

    sudo apt install snapd
    sudo snap install core
    sudo snap install xv --edge
}


function print_info {
    echo "Install Firefox CDE look and feel add-on:"
    echo "https://addons.mozilla.org/en-US/firefox/addon/cde/" 
}

# preprocess
# install_cde
# set_display_manager
# improve_fonts
set_motif_lookandfeel
# add_additional_software
print_info
