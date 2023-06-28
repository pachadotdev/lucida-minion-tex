#!/bin/bash

# set 

# if ~/.TinyTeX/texmf-local exists, do nothing
# otherwise, install TinyTeX
if [ ! -d ~/.TinyTeX/texmf-local ]; then
    wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh
fi

unzip -o lucida-type1.zip -d ~/.TinyTeX/texmf-local
unzip -o lucimacros.zip -d ~/.TinyTeX/texmf-local

mkdir -p ~/.TinyTeX/texmf-local/fonts/type1/adobe/MinionPro
unzip -o minion.zip
cp minion/pfb/*.pfb ~/.TinyTeX/texmf-local/fonts/type1/adobe/MinionPro
unzip -o minion/metrics-base.zip -d ~/.TinyTeX/texmf-local/
unzip -o minion/enc-2.000.zip -d ~/.TinyTeX/texmf-local/

mktexlsr
updmap-sys --enable Map=lucida.map
updmap-sys --enable Map=MinionPro.map
updmap-sys

# \usepackage[openg]{MinionPro} won’t show the letter “g” and \ell won’t work 
# with this typography. Here is the solution.

# replace "/afii61289" with "/uni2113" in .TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
sed -i 's/\/afii61289/\/uni2113/g' ~/.TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc

# also replace "/afii10069.ital" with "/uni0434.ital" in the same file
sed -i 's/\/afii10069.ital/\/uni0434.ital/g' ~/.TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
