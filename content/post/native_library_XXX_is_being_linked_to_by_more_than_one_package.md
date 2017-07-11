+++
date = "2017-07-11T10:42:12+02:00"
draft = false
title = "error: native library `XXX` is being linked to by more than one package, and can only be linked to by one package"

+++

# The Problem

I use [`gtk-rs`][gtk-rs] in many projects. Since I use there the bleeding edge version's I run often in error like this one.

```output
$ cargo run
error: native library `atk` is being linked to by more than one package, and can only be linked to by one package                                                             

  atk-sys v0.3.4                           
  atk-sys v0.3.4 (https://github.com/gtk-rs/sys#11344439)                              
```

The error dosn't just targets the `atk-sys` crate, You can replace `atk` with `gio`, `gdk-pixbuf` or all the other `-sys` crates from [`gtk-rs`][gtk-rs]

# Because 

This happens because the `gtk-rs` [Cargo.toml](https://github.com/gtk-rs/sys/blob/master/gtk-sys/Cargo.toml#L24) contains entries like these

```ini
# Cargo.toml
# ...

[dependencies.atk-sys]
path = "../atk-sys"
version = "0.3.4"

# ...
```

# Solution

I found a solution at https://github.com/rust-lang/cargo/issues/4186. With a little modification (the atk-sys was missing) all projects are compile fine now. Just insert this `[replace]` block, or just the crates you get the error, in your `Cargo.toml` file.

```ini
# Cargo.toml
# ...
[replace]
"atk-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
"gtk-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
"glib-sys:0.3.4" = { git =" https://github.com/gtk-rs/sys" }
"gdk-pixbuf-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
"gobject-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
"gio-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
"gdk-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
"cairo-sys-rs:0.3.4" = { git = "https://github.com/gtk-rs/cairo" }
"pango-sys:0.3.4" = { git = "https://github.com/gtk-rs/sys" }
```

[gtk-rs]: https://github.com/gtk-rs/