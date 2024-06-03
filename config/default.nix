{
  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix
    ./nvim-tree.nix
    ./keymaps.nix
    ./telescope.nix
    ./harpoon.nix
  ];

  globals.mapleader = " ";

  colorschemes.gruvbox.enable = true;
  
  opts = {
    number = true;         # Show line numbers
    relativenumber = true; # Show relative line numbers
    spell = true; 
    shiftwidth = 2;        # Tab width should be 2
  };

  plugins = {
    toggleterm = {
      enable = true;
      settings = {
	open_mapping = "[[<C-t>]]";
      };
    };
    lualine.enable = true;
    treesitter.enable = true;
    treesitter-context.enable = true;
    trouble.enable = true;
    lspkind.enable = true;
    lazygit.enable = true;
    nvim-autopairs.enable = true;
    fidget = {
      enable = true;
      progress = {
	suppressOnInsert = true;
 	ignoreDoneAlready = true;
	pollRate = 0.5;
      };
    };
    conform-nvim = {
      enable = true;
      formatOnSave = {
	lspFallback = true;
	timeoutMs = 500;
      };
      notifyOnError = true;
    };
    git-worktree = {
      enable = true;
      enableTelescope = true;
    };
    gitsigns = {
      enable = true;
      settings = {
	current_line_blame = true;
	trouble = true;
      }; 
    };
  };
  plugins.lsp = {
    enable = true;
    servers = {
      tsserver.enable = true;
      lua-ls.enable = true;
      nil_ls.enable = true;	
      rust-analyzer.enable = true;
      rust-analyzer.installCargo = true;
      rust-analyzer.installRustc = true;
    };
  };
    plugins.lsp-format.enable = true;	 
    plugins.fzf-lua.enable = true;
    plugins.luasnip.enable = true;
    plugins.cmp_luasnip.enable = true;
    plugins.which-key.enable = true;
    plugins.cmp-spell.enable = true;
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        mapping = {
          __raw = ''
            cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
          '';
        };
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
          {name = "cmp-spell";}
        ];
      };
    };
  keymaps = [
    {
      key = "<leader>c";
      action = "+context";
    }
    {
      key = "<leader>co";
      action = "<CMD>TSContextToggle<CR>";
    }
  ];

}
