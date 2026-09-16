# oneshots integration

The Hyprland screenshot bindings call the `shotty` executable from the
separate sibling project. During local development, keep that checkout at
`../oneshots` next to this repository. Published installations should use the
project's repository and a tagged release once a remote is available.

Current local reference:

- tag: `v0.1.0`
- commit: `3646cddbffece0b3cae579838508e67c366ba871`
- implementation: Rust, with `grim`/`hyprctl` capture and Tesseract OCR

The dotfiles repository deliberately does not copy the compiled binary. Build
the tool from its own checkout:

```sh
cargo install --path ../oneshots --locked
```

The resulting `shotty` command must be available in the session `PATH` before
Hyprland loads the keybindings.
