# oneshots integration

The Hyprland screenshot bindings call the `shotty` executable from the
separate [`oneshots`](https://github.com/Gongcai/oneshots) repository.
Install the tagged release with Cargo:

Current release reference:

- tag: `v0.1.0`
- commit: [`3646cddbffece0b3cae579838508e67c366ba871`](https://github.com/Gongcai/oneshots/commit/3646cddbffece0b3cae579838508e67c366ba871)
- implementation: Rust, with `grim`/`hyprctl` capture and Tesseract OCR

The dotfiles repository deliberately does not copy the compiled binary. Build
the tool from the tagged repository release:

```sh
cargo install --git https://github.com/Gongcai/oneshots.git --tag v0.1.0 --locked
```

The resulting `shotty` command must be available in the session `PATH` before
Hyprland loads the keybindings.
