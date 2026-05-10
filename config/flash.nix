{
  plugins.flash = {
    enable = true;
    settings.continue = false;
  };

  keymaps = [
    {
      mode = "n";
      key = "s";
      action = "<CMD>lua require('flash').jump({continue = false})<CR>";
      options.desc = "Flash Jump";
    }
    {
      mode = "n";
      key = "S";
      action = "<CMD>lua require('flash').treesitter()<CR>";
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o"; # Operator pending mode (e.g., after pressing 'd' or 'y')
      key = "r";
      action = "<CMD>lua require('flash').remote()<CR>";
      options.desc = "Remote Flash";
    }
    {
      mode = [
        "o"
        "x"
      ]; # Operator pending and Visual mode
      key = "R";
      action = "<CMD>lua require('flash').treesitter_search()<CR>";
      options.desc = "Treesitter Search";
    }
  ];
}
