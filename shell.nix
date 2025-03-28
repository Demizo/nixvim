{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Tools
    ripgrep
    wl-clipboard
  ];
}
