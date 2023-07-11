#!/bin/bash

# what to install

# prompt with 3 options
echo "Which font do you want to install?"
echo "2. Lucida"
echo "1. Minion Pro"
echo "3. Both"
read -p "Enter your choice (1, 2, or 3): " choice

# setup 

# if ~/.TinyTeX/texmf-local exists, do nothing
# otherwise, install TinyTeX
if [ ! -d ~/.TinyTeX/texmf-local ]; then
  echo "Installing TinyTeX..."
  wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh
fi

# if choice 1 or 3, install Lucida
if [ $choice = 1 ] || [ $choice = 3 ]; then
  echo "Installing Lucida..."
  unzip -o lucida-type1.zip -d ~/.TinyTeX/texmf-local
  unzip -o lucimacros.zip -d ~/.TinyTeX/texmf-local
  mktexlsr
  updmap-sys --enable Map=lucida.map
  updmap-sys
fi

# if choice 2 or 3, install Minion Pro
if [ $choice = 2 ] || [ $choice = 3 ]; then
  echo "Installing Minion Pro..."

  # if apt exists, then run sudo update
  if command -v apt &> /dev/null
  then
    sudo apt update

    # if cfftot1 does not exist, install it
    if ! command -v cfftot1 &> /dev/null
    then
      sudo apt install lcdf-typetools
    fi
  fi

  mkdir -p ~/.TinyTeX/texmf-local/fonts/type1/adobe/MinionPro
  for font in minion/*.otf
  do
    base=$(basename "$font" .otf)
    cfftot1 "$font" "minion-nofont/pfb/$base.pfb"
    t1dotlessj "minion-nofont/pfb/$base.pfb" "minion-nofont/pfb/${base}LCDFJ.pfb"
  done
  cp minion-nofont/pfb/*.pfb ~/.TinyTeX/texmf-local/fonts/type1/adobe/MinionPro
  unzip -o minion-nofont/metrics-base.zip -d ~/.TinyTeX/texmf-local/
  unzip -o minion-nofont/enc-2.000.zip -d ~/.TinyTeX/texmf-local/
  mktexlsr
  updmap-sys --enable Map=MinionPro.map
  updmap-sys
  
  # \usepackage[openg]{MinionPro} won’t show the letter “g” and \ell won’t work 
  # with this typography. Here is the solution.
  # replace "/afii61289" with "/uni2113" in .TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
  sed -i 's/\/afii61289/\/uni2113/g' ~/.TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
  # also replace "/afii10069.ital" with "/uni0434.ital" in the same file
  sed -i 's/\/afii10069.ital/\/uni0434.ital/g' ~/.TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
fi
