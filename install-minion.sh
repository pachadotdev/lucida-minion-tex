#!/bin/bash

# if the directory does not exist, create it
if [ ! -d "$texmflocal/fonts/type1/adobe/MinionPro" ]
then
  mkdir -p "$texmflocal/fonts/type1/adobe/MinionPro"
fi

cp -r minion-nofont/ "$texmflocal/fonts/type1/adobe/MinionPro/"

mktexlsr
# updmap-sys --syncwithtrees --enable Map=MinionPro.map
updmap-sys --enable Map=MinionPro.map
updmap-sys

# ensure MnSymbol and mathalpha are installed
tlmgr install mnsymbol
tlmgr install mathalpha
tlmgr install boondox
