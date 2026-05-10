{
  extraConfigLua = builtins.readFile ./journal.lua;

  keymaps = [
    {
      mode = "n";
      key = "<leader>j";
      action = "+journal";
    }
    {
      mode = "n";
      key = "<leader>jt";
      action = "<cmd>JournalToday<CR>";
      options = {
        desc = "Journal: Open Today";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>jl";
      action = "<cmd>JournalLast<CR>";
      options = {
        desc = "Journal: Open Last Entry";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>jd";
      action = "<cmd>JournalTodos<CR>";
      options = {
        desc = "Journal: Search Unfinished Todos";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>js";
      action = "<cmd>JournalSearch<CR>";
      options = {
        desc = "Journal: Search Entries (Recent First)";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>jp";
      action = "<cmd>JournalPrev<CR>";
      options = {
        desc = "Journal: Previous Entry";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>jn";
      action = "<cmd>JournalNext<CR>";
      options = {
        desc = "Journal: Next Entry";
        silent = true;
      };
    }
  ];
}
