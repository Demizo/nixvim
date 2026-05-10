{
  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>h";
      action = "+harpoon";
    }
    {
      mode = "n";
      key = "<leader>ha";
      action.__raw = "function() require'harpoon':list():add() end";
      options = {
        desc = "Harpoon add file";
      };
    }
    {
      mode = "n";
      key = "<leader>hh";
      action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      options = {
        desc = "Open harpoon";
      };
    }

  ];
}
