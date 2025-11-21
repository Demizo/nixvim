{ pkgs, lib, ... }:
{
  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
    ./nvim-tree.nix
    ./keymaps.nix
    ./telescope.nix
    #./harpoon.nix
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
    flash = {
      enable = true;
      settings = {
        modes = {
          search.enabled = true;
        };
      };
    };
    render-markdown.enable = true;
    bullets = {
      enable = true;
      settings = {
        outline_levels = [
          "std-"
        ];
      };
    };
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
    flutter-tools = {
      enable = true;
      settings = {
        lsp.on_attach.__raw = ''
          function(client, bufnr)
            -- Auto-format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        '';
        lsp.settings = {
          enableSdkFormatter = true;
          showTodos = true;
          renameFilesWithClasses = "prompt";
        };
      };
    };
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
      qmlls.enable = true;
      nixd.enable = true;
      nixd.settings = {
        formatting = {
          command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
        };
      };
      pyright.enable = true;
      markdown_oxide.enable = true;
      # rust-analyzer.enable = true;
      # rust-analyzer.installCargo = true;
      # rust-analyzer.installRustc = true;
    };
  };
  diagnostic.settings = {
    virtual_text = true;
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

  extraConfigLua = ''
        -- Command: :JounralToday
        vim.api.nvim_create_user_command("JournalToday", function()
          -- Get YYYY_MM_DD
          local date = os.date("%Y_%m_%d")

          -- Build path (relative to CWD or absolute if you prefer)
          local path = "journals/" .. date .. ".md"

          -- Auto-create directory if missing
          local dir = vim.fn.fnamemodify(path, ":h")
          if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
          end

          -- Create file if it does not exist
          if vim.fn.filereadable(path) == 0 then
            local f = io.open(path, "w")
            if f then f:close() end
          end

          -- Open the journal
          vim.cmd("edit " .. path)
        end, {})

        -- Command: :JournalLast
          vim.api.nvim_create_user_command("JournalLast", function()
            local journal_dir = "journals"     -- adjust if needed

            -- Expand relative → absolute
            local dir_path = vim.fn.expand(journal_dir)

            if vim.fn.isdirectory(dir_path) == 0 then
              print("Directory does not exist")
              return
            end

            -- Get list of files
            local files = vim.fn.globpath(dir_path, "*.md", false, true)

            if #files == 0 then
              print("No .md files found in folder")
              return
            end

            local latest = nil

            for _, file in ipairs(files) do
              local name = vim.fn.fnamemodify(file, ":t")

              local date_str = name:match("(%d%d%d%d)[:_%-](%d%d)[:_%-](%d%d)")

              if date_str then
    	        local y, m, d = name:match("(%d%d%d%d)[:_%-](%d%d)[:_%-](%d%d)")
    	        local numeric = tonumber(y .. m .. d)
                if numeric and (not latest or numeric > latest.numeric) then
                  latest = { numeric = numeric, file = file }
                end
              end
            end

            if not latest then
              print("No valid journal files found")
              return
            end

            vim.cmd("edit " .. latest.file)
          end, {})
  '';
}
