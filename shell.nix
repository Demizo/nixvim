{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Rust
    cargo
    rustc
    rustfmt
    rust-analyzer
    gcc
    dart
    flutter

    # Tools
    ripgrep
    wl-clipboard
  ];
}
