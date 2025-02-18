{
  keymaps = [

    # General

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>d";
      action = "\"_d";
      options = {
        desc = "Delete without yank";
      };
    }

    {
      mode = "n";
      key = "<C-s>";
      action = "<CMD>w<CR>";
      options = {
        desc = "Save file";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>y";
      action = ''"+y'';
      options = {
        desc = "Copy to system clipboard";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>p";
      action = ''"+p'';
      options.desc = "Paste from system clipboard";
    }

    {
      mode = "n";
      key = "<leader>qq";
      action = "<CMD>quitall<CR>";
      options = {
        desc = "Quit all";
      };
    }

    {
      mode = "n";
      key = "<leader>ul";
      action = ":lua ToggleLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Numbers";
      };
    }

    {
      mode = "n";
      key = "<leader>uL";
      action = ":lua ToggleRelativeLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Relative Line Numbers";
      };
    }

    {
      mode = "n";
      key = "<leader>uw";
      action = ":lua ToggleWrap()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Wrap";
      };
    }

    {
      mode = "n";
      key = "<leader>ca";
      action = ":lua vim.lsp.buf.code_action()<CR>";
      options.desc = "Code Actions";
    }

    {
      mode = "n";
      key = "<leader>rn";
      action = ":IncRename ";
      options.desc = "Rename";
    }

    # Nvim Tree

    {
      key = "<C-e>";
      action = "<CMD>NvimTreeToggle<CR>";
      options = {
        desc = "Toggle File Tree";
      };
    }

    # File
    {
      mode = "n";
      key = "<leader>f";
      action = "+find/file";
    }

    {
      key = "<leader>fm";
      action = "<CMD>lua vim.lsp.buf.format()<CR>";
      options.desc = "Format Buffer";
    }

    # Git

    {
      mode = "n";
      key = "<leader>g";
      action = "+git";
      options.desc = "+git";
    }

    {
      mode = "n";
      key = "<leader>gt";
      action = "+toggles";
    }

    {
      key = "<leader>gtb";
      action = "<CMD>Gitsigns toggle_current_line_blame<CR>";
      options.desc = "Gitsigns current line blame";
    }

    {
      key = "<leader>gtd";
      action = "<CMD>Gitsigns toggle_deleted<CR>";
      options.desc = "Gitsigns deleted";
    }

    {
      key = "<leader>gd";
      action = "<CMD>Gitsigns diffthis<CR>";
      options.desc = "Gitsigns diff this buffer";
    }

    {
      mode = "n";
      key = "<leader>gr";
      action = "+resets";
    }

    {
      key = "<leader>grh";
      action = "<CMD>Gitsigns reset_hunk<CR>";
      options.desc = "Gitsigns reset hunk";
    }

    {
      key = "<leader>grb";
      action = "<CMD>Gitsigns reset_buffer<CR>";
      options.desc = "Gitsigns reset current buffer";
    }

    # Buffer line

    {
      mode = "n";
      key = "<leader>b";
      action = "+buffer";
    }

    {
      mode = "n";
      key = "<leader>bo";
      action = "<CMD>bn<CR>";
      options.desc = "Next Buffer";
    }

    {
      mode = "n";
      key = "<leader>bi";
      action = "<CMD>bp<CR>";
      options.desc = "Previous Buffer";
    }

    # Diagnostics

    {
      mode = "n";
      key = "<leader>se";
      action = ":lua vim.diagnostic.open_float()<CR>";
      options.desc = "View diagnostic message";
    }

    {
      mode = "n";
      key = "<leader>sd";
      action = ":lua vim.diagnostic.setqflist()<CR>";
      options.desc = "View diagnostic message list";
    }

    # Tabs
    {
      mode = "n";
      key = "<leader>t";
      action = "+tab";
    }

    {
      mode = "n";
      key = "<leader>tn";
      action = "<CMD>tabnew<CR>";
      options.desc = "Create new tab";
    }

    {
      mode = "n";
      key = "<leader>td";
      action = "<CMD>tabclose<CR>";
      options.desc = "Close tab";
    }

    {
      mode = "n";
      key = "<leader>to";
      action = "<CMD>tabnext<CR>";
      options.desc = "Go to next tab";
    }

    {
      mode = "n";
      key = "<leader>ti";
      action = "<CMD>tabprevious<CR>";
      options.desc = "Go to previous tab";
    }
  ];

  extraConfigLua = ''
        function ToggleLineNumber()
        if vim.wo.number then
          vim.wo.number = false
        else
          vim.wo.number = true
    	end
    	end

    	function ToggleRelativeLineNumber()
    	if vim.wo.relativenumber then
    	  vim.wo.relativenumber = false
    	else
    	  vim.wo.relativenumber = true
    	    end
    	    end

    	    function ToggleWrap()
    	    vim.wo.wrap = not vim.wo.wrap
    	    end
    	    '';
}
