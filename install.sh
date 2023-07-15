#!/bin/bash

# what to install

# prompt with 3 options
echo "Which font do you want to install?"
echo "1. Install Lucida"
echo "2. Install Minion Pro"
echo "3. Install Both"
read -p "Enter your choice (1, 2, or 3): " choice

# setup 

# check if kpsexpand '$TEXMFLOCAL' exists
if command -v kpsexpand &> /dev/null
then
  # store the result of kpsexpand '$TEXMFLOCAL'
  export texmflocal=$(kpsexpand '$TEXMFLOCAL')
else
  # get userdir, because ~ won't work
  export texmflocal="$HOME/.TinyTeX/texmf-local"
fi

echo "Installing fonts in $texmflocal ..."

# if $texmflocal is equal to ~/.TinyTeX/texmf-local but the directory does not
# exist, install TinyTeX
if [ $texmflocal = "$HOME/.TinyTeX/texmf-local" ] && [ ! -d $texmflocal ]
then
  echo "Installing TinyTeX..."
  wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh
fi

# if choice 1 or 3, install Lucida
if [ $choice = 1 ] || [ $choice = 3 ]
then
  echo "Installing Lucida..."

  # if $texmflocal matches $HOME, don't use sudo
  if [ $texmflocal = "$HOME/.TinyTeX/texmf-local" ]
  then
    bash install-lucida.sh
  else
    sudo bash install-lucida.sh
  fi
fi

# if choice 2 or 3, install Minion Pro
if [ $choice = 2 ] || [ $choice = 3 ]
then
  echo "Installing Minion Pro..."

  # if there are no files matching MinionPro, then run cfftot1
  if ! ls minion-nofont/fonts/type1/adobe/MinionPro/MinionPro*.pfb &> /dev/null
  then
    # if cfftot1 does not exist, install it
    if ! command -v cfftot1 &> /dev/null
    then
      # if apt exists, then run sudo update and install
      if command -v apt &> /dev/null
      then
        echo "Installing lcdf-typetools..."
        sudo apt update
        sudo apt install lcdf-typetools
      fi
    fi

    if command -v cfftot1 &> /dev/null
    then
      for font in minion/*.otf
      do
        base=$(basename "$font" .otf)
        cfftot1 "$font" "minion-nofont/fonts/type1/adobe/MinionPro/$base.pfb"
        t1dotlessj "minion-nofont/fonts/type1/adobe/MinionPro/$base.pfb" "minion-nofont/fonts/type1/adobe/MinionPro/${base}LCDFJ.pfb"
      done
    else
      echo "Please get the fonts in pfb format or install cfftot1."
      # stop the script
      exit 1
    fi
  fi

  # if $texmflocal matches $HOME, don't use sudo
  if [ $texmflocal = "$HOME/.TinyTeX/texmf-local" ]
  then
    bash install-minion.sh
  else
    sudo bash install-minion.sh
  fi
fi

# unset the variables
unset texmflocal
