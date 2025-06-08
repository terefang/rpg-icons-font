#!/usr/bin/env -S just --justfile

XDIR := justfile_directory()
XFNT := XDIR+"/static"

DND_BASE := 'https://github.com/intrinsical/tw-dnd/archive/refs/heads/main.zip'
LORC_BASE := 'https://game-icons.net/archives/svg/zip/000000/transparent/game-icons.net.svg.zip'

default: build

build: dl-dnd dl-lorc
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp {{XFNT}}
    [ -f {{XFNT}}/RpgIcons.otf ] || (
        GBASE=$((0xe000))
        echo "// auto-generated $(date)" > {{XFNT}}/diceset.typ
        cat > {{XDIR}}/tmp/compile_font.ff <<EOT
        New()
        Reencode("UnicodeFull")
        SetFondName("DICE")
        SetFontNames("RpgIcons","RpgIcons","RpgIcons","Book","CC BY-SA 4.0 -- https://github.com/intrinsical/tw-dnd/tree/main/icons ; CC BY 3.0 -- https://game-icons.net/","1.0-2025")
    EOT
        for x in {{XDIR}}/icons/*.svg; do
            y=$(basename $x .svg)
            echo "#let ds-${y}-g = text(font:\"RpgIcons\",str.from-unicode($GBASE));" >> {{XFNT}}/diceset.typ
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GBASE))
            Import("$x")
            SetGlyphName("$y", 0)
            RemoveOverlap()
    EOT
            GBASE=$(($GBASE+1))
        done
        echo 'Generate("{{XFNT}}/RpgIcons.otf")' >> {{XDIR}}/tmp/compile_font.ff
        fontforge -lang=ff -script {{XDIR}}/tmp/compile_font.ff
    )
    rm -rf {{XDIR}}/tmp {{XDIR}}/icons

dl-dnd:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons
    (cd {{XDIR}}/tmp && wget -O tmp.zip {{DND_BASE}} && unzip tmp.zip )
    (cd {{XDIR}}/tmp/tw-dnd-main/icons/ && rename -v 's/\//-/' */*.svg && mv *.svg {{XDIR}}/icons/)
    rm -rf {{XDIR}}/tmp

dl-lorc:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons
    (cd {{XDIR}}/tmp && wget -O tmp.zip {{LORC_BASE}} && unzip tmp.zip )
    (cd {{XDIR}}/tmp/icons/000000/transparent/1x1/ && rename -v 's/\//-/' */*.svg && mv *.svg {{XDIR}}/icons/)
    rm -rf {{XDIR}}/tmp
