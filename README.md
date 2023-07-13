# Install Minion Pro and Lucida for TeX

## About

This repository provides a script to install the Lucida and Minion Pro fonts for
TeX. I use TinyTeX, but this also works with TeX Live and MiKTeX.

See [varsityblues](https://github.com/pachadotdev/varsityblues) for a set of
complete LaTeX templates to be used with R Markdown or Quarto.

You can compare the differences here:

* Computer Modern (TeX default): [pdf](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/computer-modern.pdf) and [tex](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/computer-modern.tex)
* Lucida: [pdf](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/lucida.pdf) and [tex](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/lucida.tex)
* Lucida and Minion Pro: [pdf](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/lucida-and-minion.pdf) and [tex](https://github.com/pachadotdev/lucida-minion-tex/blob/main/demo/lucida-and-minion.tex)

Lucida is a commercial font that can be purchased from [TUG](https://www.tug.org/store/lucida/index.html).
After purchasing the font, you will receive a zip files with the fonts and the 
macros (lucida-type1.zip and lucimacros.zip).

Minion Pro comes with Adobe Illustrator or can be purchased by separate from
[Adobe](https://fonts.adobe.com/fonts/minion).

If you email me, I can send you the PFB files for Minion Pro if you can prove
that you have legally obtained the font. I believe in Open Source, but I also
believe in respecting the rights of the creators of the fonts.

## Instructions

### Clone this repository

Either

```bash
git clone --depth 1 https://github.com/pachadotdev/lucida-minion-tex.git
```

or

```bash
git clone --depth 1 git@github.com:pachadotdev/lucida-minion-tex.git
```

### Copy Lucida files

Put the corresponding zip files for Lucida in the root folder of this repository.

### Copy Minion Pro files

#### If you only have the font  in OTF format

Create the `minion` folder in the root of this repository and put the Minion Pro
fonts in OTF format into it. This corresponds to the next files:

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

If you are on Ubuntu/Debian, the script from the next section will install
`lcdf-typetools`, which provides `cfftot1` and `t1dotlessj` and allow to convert
the fonts to the required format for TeX.

For other Linux and Unix systems (i.e., Mac), you'll need to install
`lcdf-typetools`.

```bash
# Fedora/RedHat
sudo dnf install lcdf-typetools

# Mac
brew install lcdf-typetools

# I don't know about other Linux/Unix systems
```

#### If you have the font in PFB format

Copy the PFB files to the `minion-nofont/pfb`.

### Run the script for Linux (and also Mac or Unix)

Run the script `install.sh` and select the available options:

1. Install Lucida
2. Install Minion Pro
3. Install Both

```bash
cd lucida-minion-tex
bash install.sh
```

### Steps for Windows

1. Create the `C:\texfonts` folder.
2. Unzip the `lucida-type1.zip` and `lucimacros.zip` files into `C:\texfonts`.
3. Copy `minion-nofont` contents to folder to `C:\texfonts`, unzip all the zip files and then delete the zip files.
4. Go to the Miktex configuration (Start > Programs > MiKTeX > Maintenance).
5. Add the folder created in the first step (see [image 1](https://github.com/pachadotdev/lucida-minion-tex/blob/main/image1.png)).
6. Update the FNDB and formats (see [image 2](https://github.com/pachadotdev/lucida-minion-tex/blob/main/image2.png)) don't forget to click "apply" and then "ok".
7. Restart the computer.

To convert the font from OTF to TeX format you need to run something of the form:

```bash
@echo off

echo "Creating PostScript fonts ..."

for %%i in (minion/*.otf) do cfftot1    minion/otf/%%i minion-nofont/pfb/%%~ni.pfb
for %%i in (minion/*.otf) do t1dotlessj minion/pfb/%%~ni.pfb minion-nofont/pfb/%%~niLCDFJ.pfb
```

I don't use Windows, so this is what my imagination says is the adaption from the Linux script.
