#!/bin/bash

cp -r minion-nofont/* "$texmflocal/"

mktexlsr
updmap-sys --syncwithtrees
updmap-sys --enable Map=MinionPro.map
updmap-sys

# ensure MnSymbol and mathalpha are installed
tlmgr install mnsymbol
tlmgr install mathalpha
tlmgr install boondox
