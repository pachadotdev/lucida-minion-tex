# Install Minion Pro and Lucida for TeX

## About

This repository provides a script to install the Lucida and Minion Pro fonts for TeX. Here's a [pdf](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/computer-modern.pdf) created from a [tex](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/computer-modern.tex) file that uses Computer Modern and here's another [pdf](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/lucida-and-minion.pdf) created from modification of the [tex](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/lucida-and-minion.tex) file using Lucida and Minion Pro.

Lucida is a commercial font that can be purchased from [TUG](https://www.tug.org/store/lucida/index.html). After purchasing the font, you will receive a zip files with the fonts and the macros (lucida-type1.zip and lucimacros.zip).

Minion Pro comes with Adobe Illustrator or can be purchased by separate from [Adobe](https://fonts.adobe.com/fonts/minion).

## Instructions

### General

Clone this repository:

```bash
git clone https://github.com/pachadotdev/lucida-minion-tex.git
```

Put the corresponding zip files for Lucida in the root folder of this repository.

If you don't plan to install Minion Pro, skip the rest of this section.

Create the `minion` folder in the root of this repository and put the Minion Pro fonts in it. This corresponds to the next files:

```
MinionPro-BoldCnIt.otf
MinionPro-BoldCn.otf
MinionPro-BoldIt.otf
MinionPro-Bold.otf
MinionPro-It.otf
MinionPro-MediumIt.otf
MinionPro-Medium.otf
MinionPro-Regular.otf
MinionPro-SemiboldIt.otf
MinionPro-Semibold.otf
```

The script in the next section will convert the fonts and put them in the `minion-nofont` directory, which contains the metrics and other files required for TeX.

### Linux

Run the script `install.sh` and select the available options:

1. Lucida
2. Minion Pro
3. Both

```bash
sudo bash -c "$(wget -qO- https://github.com/pachadotdev/lucida-minion-tex/blob/main/install.sh)"
```

This should also work with Mac, but you'll need to install `lcdf-typetools` or any other tool that provides `cfftot1` and `t1dotlessj`, which are only required for Minion Pro.

### Windows

1. Create the `C:\texfonts` folder.
2. Unzip the `lucida-type1.zip` and `lucimacros.zip` files into the folder created in the previous step.
3. Go to the Miktex configuration (Start > Programs > MiKTeX > Maintenance).
4. Add the folder created in the first step (see [image 1](https://github.com/pachadotdev/lucida-minion-tex/blob/main/image1.png)).
5. Update the FNDB and formats (see [image 2](https://github.com/pachadotdev/lucida-minion-tex/blob/main/image2.png)) don't forget to click "apply" and then "ok".

To convert the font from OTF to TeX format you need to run something of the form:

```bash
@echo off

echo "Creating PostScript fonts ..."

for %%i in (minion/*.otf) do cfftot1    minion/otf/%%i minion-nofont/pfb/%%~ni.pfb
for %%i in (minion/*.otf) do t1dotlessj minion/pfb/%%~ni.pfb minion-nofont/pfb/%%~niLCDFJ.pfb
```

I don't use Windows, so this is what my imagination says is the adaption from the Linux script.
