# rpg icons font

## Prerequisites

* a suitable complete POSIX environment and shell (bash, mksh, …) like Linux
* wget download tool — https://www.gnu.org/software/wget/
* just build tool – https://github.com/casey/just/
* fontforge – https://fontforge.org/

## Building

```
$ git clone https://github.com/terefang/rpg-icons-font
$ cd rpg-icons-font
$ just build
```

this will download the common icons and compile the font and typst include into the `static/` directory.

## Icons used

* DnD Icons — https://github.com/intrinsical/tw-dnd
* Game Icons — https://game-icons.net/
* Feather Icons — https://github.com/feathericons/feather
* OctIcons — https://github.com/primer/octicons
* Glyph Iconset — https://github.com/chutichhuy/glyph-iconset
* Core UI Icons — https://github.com/coreui/coreui-icons
