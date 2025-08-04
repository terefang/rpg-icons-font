#!/usr/bin/env -S just --justfile

XDIR := justfile_directory()
XFNT := XDIR+"/static"

XNAME := 'RpgGameIcons'

DND_BASE := 'https://github.com/intrinsical/tw-dnd/archive/refs/heads/main.zip'
LORC_BASE := 'https://game-icons.net/archives/svg/zip/000000/transparent/game-icons.net.svg.zip'
FE_BASE := 'https://github.com/feathericons/feather/archive/refs/heads/main.zip'
OI_BASE := 'https://github.com/primer/octicons/archive/refs/heads/main.zip'
OP_BASE := 'https://github.com/iconic/open-iconic/archive/refs/heads/master.zip'
GI_BASE := 'https://github.com/chutichhuy/glyph-iconset/archive/refs/heads/master.zip'
CI_BASE := 'https://github.com/coreui/coreui-icons/archive/refs/heads/main.zip'
LC_BASE := 'https://github.com/lucide-icons/lucide/archive/refs/heads/main.zip'

default: build

clean:
    #!/bin/sh
    rm -rf {{XDIR}}/tmp {{XDIR}}/icons {{XFNT}}

build: dl-dnd dl-lorc dl-fe dl-oi dl-opi dl-gi dl-ci dl-lc
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp {{XFNT}}
    [ -f {{XFNT}}/{{XNAME}}.otf ] || (
        cat > {{XFNT}}/diceset.css  <<EOT
        /* auto-generated $(date) */

        @font-face {
          font-family: {{XNAME}};
          src: url(./{{XNAME}}.woff2) format("woff2"), url(./{{XNAME}}.otf) format("truetype");
        }
        .ds {
               display: inline-block;
               font: normal normal normal 14px/1 {{XNAME}};
               font-size: inherit;
               text-rendering: auto;
               -webkit-font-smoothing: antialiased;
               -moz-osx-font-smoothing: grayscale;
                vertical-align: +15%;
             }
        .ds-hc-lg {
          font-size: 1.33333333em;
          line-height: 0.75em;
        }
        .ds-hc-2x {
          font-size: 2em;
        }
        .ds-hc-3x {
          font-size: 3em;
        }
        .ds-hc-4x {
          font-size: 4em;
        }
        .ds-hc-5x {
          font-size: 5em;
        }
        .ds-hc-fw {
          width: 1.28571429em;
          text-align: center;
        }
        .ds-hc-ul {
          padding-left: 0;
          margin-left: 2.14285714em;
          list-style-type: none;
        }
        .ds-hc-ul > li {
          position: relative;
        }
        .ds-hc-li {
          position: absolute;
          left: -2.14285714em;
          width: 2.14285714em;
          top: 0.14285714em;
          text-align: center;
        }
        .ds-hc-li.ds-hc-lg {
          left: -1.85714286em;
        }
        .ds-hc-border {
          padding: .1em .25em;
          border: solid 0.1em #9e9e9e;
          border-radius: 2px;
        }
        .ds-hc-border-circle {
          padding: .1em .25em;
          border: solid 0.1em #9e9e9e;
          border-radius: 50%;
        }
        .ds.pull-left {
          float: left;
          margin-right: .15em;
        }
        .ds.pull-right {
          float: right;
          margin-left: .15em;
        }
        .ds-hc-spin {
          -webkit-animation: ds-spin 1.5s infinite linear;
                  animation: ds-spin 1.5s infinite linear;
        }
        .ds-hc-spin-reverse {
          -webkit-animation: ds-spin-reverse 1.5s infinite linear;
                  animation: ds-spin-reverse 1.5s infinite linear;
        }
        @-webkit-keyframes ds-spin {
          0% {
            -webkit-transform: rotate(0deg);
                    transform: rotate(0deg);
          }
          100% {
            -webkit-transform: rotate(359deg);
                    transform: rotate(359deg);
          }
        }
        @keyframes ds-spin {
          0% {
            -webkit-transform: rotate(0deg);
                    transform: rotate(0deg);
          }
          100% {
            -webkit-transform: rotate(359deg);
                    transform: rotate(359deg);
          }
        }
        @-webkit-keyframes ds-spin-reverse {
          0% {
            -webkit-transform: rotate(0deg);
                    transform: rotate(0deg);
          }
          100% {
            -webkit-transform: rotate(-359deg);
                    transform: rotate(-359deg);
          }
        }
        @keyframes ds-spin-reverse {
          0% {
            -webkit-transform: rotate(0deg);
                    transform: rotate(0deg);
          }
          100% {
            -webkit-transform: rotate(-359deg);
                    transform: rotate(-359deg);
          }
        }
        .ds-hc-rotate-90 {
          -webkit-transform: rotate(90deg);
              -ms-transform: rotate(90deg);
                  transform: rotate(90deg);
        }
        .ds-hc-rotate-180 {
          -webkit-transform: rotate(180deg);
              -ms-transform: rotate(180deg);
                  transform: rotate(180deg);
        }
        .ds-hc-rotate-270 {
          -webkit-transform: rotate(270deg);
              -ms-transform: rotate(270deg);
                  transform: rotate(270deg);
        }
        .ds-hc-flip-horizontal {
          -webkit-transform: scale(-1, 1);
              -ms-transform: scale(-1, 1);
                  transform: scale(-1, 1);
        }
        .ds-hc-flip-vertical {
          -webkit-transform: scale(1, -1);
              -ms-transform: scale(1, -1);
                  transform: scale(1, -1);
        }
        .ds-hc-stack {
          position: relative;
          display: inline-block;
          width: 2em;
          height: 2em;
          line-height: 2em;
          vertical-align: middle;
        }
        .ds-hc-stack-1x,
        .ds-hc-stack-2x {
          position: absolute;
          left: 0;
          width: 100%;
          text-align: center;
        }
        .ds-hc-stack-1x {
          line-height: inherit;
        }
        .ds-hc-stack-2x {
          font-size: 2em;
        }
        .ds-hc-inverse {
          color: #ffffff;
        }
    EOT
        echo "// auto-generated $(date)" > {{XFNT}}/diceset.typ
        echo "# --- auto-generated $(date)" > {{XFNT}}/diceset.names
        cat > {{XDIR}}/tmp/compile_font.ff <<EOT
        New()
        Reencode("UnicodeFull")
        SetFondName("DICE")
        SetFontNames("{{XNAME}}","{{XNAME}}","{{XNAME}}","Book","CC BY-SA","1.0-2025")
    EOT
        GBASE=$((0xe000))
        for z in pf2 ps; do
            GINDEX=$GBASE
            for x in {{XDIR}}/src/$z/*.svg; do
                y=$(basename $x .svg | tr -d '[[:space:]]' | tr -c '[a-zA-Z0-9\-]+' '-'| sed -E 's/\-+$//g'| sed -E 's/\-+/-/g')
                echo "#let ds-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GINDEX));" >> {{XFNT}}/diceset.typ
                printf ".ds-${y}:before { content: '\\%04x'; } \n" $GINDEX >> {{XFNT}}/diceset.css
                printf "%-40s   %04X\n" "${y}" $GINDEX >> {{XFNT}}/diceset.names
                cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
                Select(UCodePoint($GINDEX))
                Print("$x")
                Import("$x")
                SetGlyphName("$y", 0)
                RemoveOverlap()
    EOT
                GINDEX=$(($GINDEX+1))
            done
            GBASE=$(($GBASE+0x100))
        done
        GBASE=$((0xf0000))
        for z in dnd fe opi gi cil; do
            GINDEX=$GBASE
            for x in {{XDIR}}/icons/$z/*.svg; do
                y=$(basename $x .svg | tr -d '[[:space:]]' | tr -c '[a-zA-Z0-9\-]' '-'| sed -E 's/\-+$//g'| sed -E 's/\-+/-/g')
                echo "#let ds-${z}-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GINDEX));" >> {{XFNT}}/diceset.typ
                printf ".ds-${z}-${y}:before { content: '\\%04x'; } \n" $GINDEX >> {{XFNT}}/diceset.css
                printf "%-40s   %04X\n" "${z}-${y}" $GINDEX >> {{XFNT}}/diceset.names
                cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
                    Select(UCodePoint($GINDEX))
                    Print("$x")
                    Import("$x")
                    SetGlyphName("$z-$y", 0)
                    RemoveOverlap()
    EOT
                GINDEX=$(($GINDEX+1))
            done
            GBASE=$(($GBASE+0x1000))
        done
        GINDEX=$GBASE
        for x in {{XDIR}}/icons/lorc/*.svg; do
            y=$(basename $x .svg | tr -d '[[:space:]]' | tr -c '[a-zA-Z0-9\-]+' '-'| sed -E 's/\-+$//g'| sed -E 's/\-+/-/g')
            echo "#let ds-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GINDEX));" >> {{XFNT}}/diceset.typ
            printf ".ds-${y}:before { content: '\\%04x'; } \n" $GINDEX >> {{XFNT}}/diceset.css
            printf "%-40s   %04X\n" "${y}" $GINDEX >> {{XFNT}}/diceset.names
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GINDEX))
            Print("$x")
            Import("$x")
            SetGlyphName("$y", 0)
            RemoveOverlap()
    EOT
            GINDEX=$(($GINDEX+1))
        done
        GBASE=$(($GBASE+0x2000))
        GINDEX=$GBASE
        for x in {{XDIR}}/icons/oi/*.svg; do
            y=$(basename $x -24.svg | tr -d '[[:space:]]' | tr -c '[a-zA-Z0-9\-]+' '-'| sed -E 's/\-+$//g'| sed -E 's/\-+/-/g')
            echo "#let ds-oi-${y}-g = text(font:\"{{XNAME}}\",str.from-unicode($GINDEX));" >> {{XFNT}}/diceset.typ
            printf ".ds-oi-${y}:before { content: '\\%04x'; } \n" $GINDEX >> {{XFNT}}/diceset.css
            printf "%-40s   %04X\n" "oi-${y}" $GINDEX >> {{XFNT}}/diceset.names
            cat >> {{XDIR}}/tmp/compile_font.ff <<EOT
            Select(UCodePoint($GINDEX))
            Print("$x")
            Import("$x")
            SetGlyphName("oi-$y", 0)
            RemoveOverlap()
    EOT
            GINDEX=$(($GINDEX+1))
        done
        echo 'Generate("{{XFNT}}/{{XNAME}}.otf")' >> {{XDIR}}/tmp/compile_font.ff
        fontforge -lang=ff -script {{XDIR}}/tmp/compile_font.ff
    ) && rm -rf {{XDIR}}/tmp {{XDIR}}/icons
    woff2_compress {{XFNT}}/{{XNAME}}.otf

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

dl-lc:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/lc
    (cd {{XDIR}}/tmp/icons/ && wget -O tmp.zip {{LC_BASE}} && unzip -o -j tmp.zip */icons/*.svg)
    (cd {{XDIR}}/tmp/icons/ && mv *.svg {{XDIR}}/icons/lc/)
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

dl-gi:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/gi
    (cd {{XDIR}}/tmp/icons/ && wget -O tmp.zip {{GI_BASE}} && unzip -o -j tmp.zip )
    (cd {{XDIR}}/tmp/icons/ && rename 's/si-glyph-//' *.svg && mv *.svg {{XDIR}}/icons/gi/)
    rm -rf {{XDIR}}/tmp
    mv {{XDIR}}/icons/gi/dice-6.svg {{XDIR}}/icons/gi/dice-4.svg
    mv {{XDIR}}/icons/gi/dice-6-.svg {{XDIR}}/icons/gi/dice-6.svg

dl-ci:
    #!/bin/sh
    mkdir -p {{XDIR}}/tmp/icons  {{XDIR}}/icons/cil
    (cd {{XDIR}}/tmp/icons/ && wget -O tmp.zip {{CI_BASE}} && unzip -o -j tmp.zip )
    (cd {{XDIR}}/tmp/icons/ && rm -f cif-*.svg cib-*.svg && rename 's/cil-//' *.svg && mv *.svg {{XDIR}}/icons/cil/)
    rm -rf {{XDIR}}/tmp
