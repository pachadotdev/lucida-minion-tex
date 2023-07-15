#!/bin/bash

# \usepackage[openg]{MinionPro} won’t show the letter "g" and "\ell" won’t
# work with this typography. Here is the solution.

# extract
unzip -o minion-metrics-base.zip -d minion-nofont/
unzip -o minion-enc-2.000.zip -d minion-nofont/

# replace "/afii61289" with "/uni2113" in .TinyTeX/texmf-local/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc
sed -i 's/\/afii61289/\/uni2113/g' "minion-nofont/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc"
    
# also replace "/afii10069.ital" with "/uni0434.ital" in the same file
sed -i 's/\/afii10069.ital/\/uni0434.ital/g' "minion-nofont/fonts/enc/dvips/MinionPro/base-MinionPro-ab.enc"
