# caelestia-dots

Personal Hyprland dotfiles for a Caelestia-only desktop, with a patched
Hyprglass liquid-glass compositor effect and a custom `shotty` screenshot
workflow.

![Caelestia desktop preview](assets/desktop-preview.png)

This repository contains the configuration layer around the shell fork. The
shell source itself lives in the separate [caelestia-shell fork](https://github.com/Gongcai/caelestia-shell).
The Hyprglass source patch is documented by that repository in
[`docs/hyprglass-integration.md`](https://github.com/Gongcai/caelestia-shell/blob/main/docs/hyprglass-integration.md).

## Scope

- Hyprland Lua configuration and liquid-glass layer rules
- Caelestia shell settings and optional per-monitor widget examples
- Hypridle and Hyprlock configuration
- Caelestia startup, clipboard and action helpers
- Keybindings for the separately maintained `oneshots` / `shotty` project

DMS is not part of this setup. The old shell-switch fallback and generated DMS
configuration are intentionally excluded.

## Requirements

- Arch Linux or another Wayland environment with Hyprland
- Caelestia shell and CLI
- Hyprglass built from the patched source described by the shell fork
- `wl-clipboard`, `cliphist`, `fcitx5`, `NetworkManager`, `polkit-kde-agent`
- `grim`, `tesseract` and the Rust `shotty` binary for screenshot bindings
- `kitty`, `dolphin`, `pavucontrol`, `brightnessctl`, `playerctl` and other commands enabled
  in `hypr/hyprland.lua`

The package list is intentionally not treated as universal. Review the
commands and remove hardware- or application-specific bindings before using
this configuration on another machine.

## Install

Install the shell fork first, then copy the configuration files into the
standard locations:

```sh
mkdir -p ~/.config/hypr ~/.config/caelestia ~/.local/bin
cp hypr/hyprland.lua hypr/hyprglass.lua hypr/hypridle.conf hypr/hyprlock.conf ~/.config/hypr/
cp caelestia/shell.example.json ~/.config/caelestia/shell.json
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/caelestia-* ~/.local/bin/audio-control
```

The monitor files are examples only. Copy them to
`~/.config/caelestia/monitors/<output-name>/shell.json` after changing the
wallpaper paths and widget coordinates for the target display.

The Hyprland file intentionally does not declare monitor modes or EDID names.
Add those in a local override after confirming the output names with
`hyprctl monitors`.

## Wallpaper

The preview uses the included [`output.mp4`](assets/wallpaper/output.mp4)
video wallpaper. Install it into the default wallpaper directory with:

```sh
mkdir -p ~/Pictures/Wallpapers
cp assets/wallpaper/output.mp4 ~/Pictures/Wallpapers/output.mp4
```

## Screenshot Tool

`shotty` is not a system screenshot utility. It is the companion Rust project
[`oneshots`](https://github.com/Gongcai/oneshots), currently released as
`v0.1.0` (`3646cdd`). It provides frozen region selection, window/screen
capture, image clipboard output and selectable OCR for CJK text.

Install the tagged release and put the binary on `PATH`:

```sh
cargo install --git https://github.com/Gongcai/oneshots.git --tag v0.1.0 --locked
```

The bindings are:

| Binding | Action |
| --- | --- |
| `Print` | Region to image clipboard |
| `Super + Print` | Region OCR preview |
| `Shift + Print` | Region save |
| `Ctrl + Print` | Screen to clipboard and save |
| `Super + Shift + Print` | Current window to clipboard |
| `Super + Ctrl + Print` | Current window OCR preview |

The `oneshots` project is kept separate because it has its own source tree,
Cargo lockfile and release cadence. The screenshot bindings in this repository
only require the installed `shotty` command.

## Secrets and Local Overrides

Never commit a populated `githubToken`, private keys, browser state, or
personal wallpaper files. The included `assets/wallpaper/output.mp4` is an
intentional public example. `caelestia/shell.example.json` contains empty
GitHub fields and portable wallpaper/weather defaults. Put personal values in
the ignored `~/.config/caelestia/shell.json` instead.

Generated DMS files, backup Hyprland configurations, compiled Hyprglass
libraries and the compiled `shotty` binary are not dotfiles and are not stored
here.
