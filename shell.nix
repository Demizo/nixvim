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

    # Tools
    ripgrep
    wl-clipboard
  ];
}
