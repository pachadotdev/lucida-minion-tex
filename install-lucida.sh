#!/bin/bash

unzip -o lucida-type1.zip -d "$texmflocal/"
unzip -o lucimacros.zip -d "$texmflocal/"
mktexlsr
updmap-sys --syncwithtrees
updmap-sys --enable Map=lucida.map
updmap-sys
