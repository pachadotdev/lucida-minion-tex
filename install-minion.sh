#!/bin/bash

# if the directory does not exist, create it
if [ ! -d "$texmflocal/fonts/type1/adobe/MinionPro" ]
then
  mkdir -p "$texmflocal/fonts/type1/adobe/MinionPro"
fi

cp -r minion-nofont/pfb/*.pfb "$texmflocal/fonts/type1/adobe/MinionPro"
unzip -o minion-nofont/metrics-base.zip -d "$texmflocal/"
unzip -o minion-nofont/enc-2.000.zip -d "$texmflocal/"
    
# \usepackage[openg]{MinionPro} won’t show the letter "g" and "\ell" won’t
# work with this typography. Here is the solution.

# replace "/afii61289" with "/uni2113" in .TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
sed -i 's/\/afii61289/\/uni2113/g' "$texmflocal/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc"
    
# also replace "/afii10069.ital" with "/uni0434.ital" in the same file
sed -i 's/\/afii10069.ital/\/uni0434.ital/g' "$texmflocal/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc"

mktexlsr
# updmap-sys --syncwithtrees --enable Map=MinionPro.map
updmap-sys --enable Map=MinionPro.map
updmap-sys

# ensure MnSymbol and mathalpha are installed
tlmgr install mnsymbol
tlmgr install mathalpha
tlmgr install boondox
