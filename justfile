#!/usr/bin/env -S just --justfile

XDIR := justfile_directory()
XFNT := XDIR+"/static"

XNAME := 'RpgGameIcons'

DND_BASE := 'https://github.com/intrinsical/tw-dnd/archive/refs/heads/main.zip'
LORC_BASE := 'https://game-icons.net/archives/svg/zip/000000/transparent/game-icons.net.svg.zip'
FE_BASE := 'https://github.com/feathericons/feather/archive/refs/heads/main.zip'
OI_BASE := 'https://github.com/primer/octicons/archive/refs/heads/main.zip'
OP_BASE := 'https://github.com/iconic/open-iconic/archive/refs/heads/master.zip'

default: build

clean:
    #!/bin/sh
    rm -rf {{XDIR}}/tmp {{XDIR}}/icons {{XFNT}}

build: dl-dnd dl-lorc dl-fe dl-oi dl-opi
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp {{XFNT}}
    [ -f {{XFNT}}/{{XNAME}}.otf ] || (
        GBASE=$((0xe000))
        echo "// auto-generated $(date)" > {{XFNT}}/diceset.typ
        cat > {{XDIR}}/tmp/compile_font.ff <<EOT
        New()
        Reencode("UnicodeFull")
        SetFondName("DICE")
        SetFontNames("{{XNAME}}","{{XNAME}}","{{XNAME}}","Book","CC BY-SA","1.0-2025")
    EOT
        for x in {{XDIR}}/icons/dnd/*.svg; do
            y=$(basename $x .svg)
            echo "#let ds-dnd-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GBASE));" >> {{XFNT}}/diceset.typ
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GBASE))
            Import("$x")
            SetGlyphName("dnd-$y", 0)
            RemoveOverlap()
    EOT
            GBASE=$(($GBASE+1))
        done
        for x in {{XDIR}}/icons/lorc/*.svg; do
            y=$(basename $x .svg)
            echo "#let ds-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GBASE));" >> {{XFNT}}/diceset.typ
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GBASE))
            Import("$x")
            SetGlyphName("$y", 0)
            RemoveOverlap()
    EOT
            GBASE=$(($GBASE+1))
        done
        for x in {{XDIR}}/icons/fe/*.svg; do
            y=$(basename $x .svg)
            echo "#let ds-fe-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GBASE));" >> {{XFNT}}/diceset.typ
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GBASE))
            Import("$x")
            SetGlyphName("fe-$y", 0)
            RemoveOverlap()
    EOT
            GBASE=$(($GBASE+1))
        done
        for x in {{XDIR}}/icons/oi/*.svg; do
            y=$(basename $x -24.svg)
            echo "#let ds-oi-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GBASE));" >> {{XFNT}}/diceset.typ
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GBASE))
            Import("$x")
            SetGlyphName("oi-$y", 0)
            RemoveOverlap()
    EOT
            GBASE=$(($GBASE+1))
        done
        for x in {{XDIR}}/icons/opi/*.svg; do
            y=$(basename $x .svg)
            echo "#let ds-opi-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GBASE));" >> {{XFNT}}/diceset.typ
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GBASE))
            Import("$x")
            SetGlyphName("opi-$y", 0)
            RemoveOverlap()
    EOT
            GBASE=$(($GBASE+1))
        done
        echo 'Generate("{{XFNT}}/{{XNAME}}.otf")' >> {{XDIR}}/tmp/compile_font.ff
        fontforge -lang=ff -script {{XDIR}}/tmp/compile_font.ff
    )
    rm -rf {{XDIR}}/tmp {{XDIR}}/icons

dl-dnd:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/dnd
    (cd {{XDIR}}/tmp && wget -O tmp.zip {{DND_BASE}} && unzip tmp.zip )
    (cd {{XDIR}}/tmp/tw-dnd-main/icons/ && rename -v 's/\//-/' */*.svg && mv *.svg {{XDIR}}/icons/dnd/)
    rm -rf {{XDIR}}/tmp

dl-lorc:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/lorc
    (cd {{XDIR}}/tmp && wget -O tmp.zip {{LORC_BASE}} && unzip tmp.zip )
    (cd {{XDIR}}/tmp/icons/000000/transparent/1x1/ && rename -v 's/\//-/' */*.svg && mv *.svg {{XDIR}}/icons/lorc/)
    rm -rf {{XDIR}}/tmp

dl-fe:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/fe
    (cd {{XDIR}}/tmp/icons/ && wget -O tmp.zip {{FE_BASE}} && unzip -o -j tmp.zip )
    (cd {{XDIR}}/tmp/icons/ && mv *.svg {{XDIR}}/icons/fe/)
    rm -rf {{XDIR}}/tmp

dl-oi:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/oi
    (cd {{XDIR}}/tmp/icons/ && wget -O tmp.zip {{OI_BASE}} && unzip -o -j tmp.zip )
    (cd {{XDIR}}/tmp/icons/ && mv *-24.svg {{XDIR}}/icons/oi/)
    rm -rf {{XDIR}}/tmp

dl-opi:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/opi
    (cd {{XDIR}}/tmp/icons/ && wget -O tmp.zip {{OP_BASE}} && unzip -o -j tmp.zip )
    (cd {{XDIR}}/tmp/icons/ && mv *.svg {{XDIR}}/icons/opi/)
    rm -rf {{XDIR}}/tmp
