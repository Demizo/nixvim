{ pkgs, lib, ... }:
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
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    spell = true;
    shiftwidth = 2; # Tab width should be 2
  };

  plugins = {
    web-devicons.enable = true;
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
      settings.progress = {
        suppress_on_insert = true;
        ignore_done_already = true;
      };
    };
    conform-nvim = {
      enable = true;
      settings.formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };
      settings.notify_on_error = true;
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
    inc-rename = {
      enable = true;
    };
    rustaceanvim.enable = true;
    flutter-tools.enable = true;
  };
  plugins.mini = {
    enable = true;
    modules = {
      ai = { };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
    };
  };
  plugins.lsp = {
    enable = true;
    servers = {
      ts_ls.enable = true;
      lua_ls.enable = true;
      nixd.enable = true;
      nixd.settings = {
        formatting = {
          command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
        };
      };
      dartls.enable = true;
      pyright.enable = true;
      # rust-analyzer.enable = true;
      # rust-analyzer.installCargo = true;
      # rust-analyzer.installRustc = true;
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
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
        { name = "cmp-spell"; }
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
