{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Rust
    cargo
    rustc
    rustfmt
    rust-analyzer
    gcc

    # Tools
    ripgrep
    wl-clipboard
  ];
}
