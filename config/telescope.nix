{
  plugins.telescope = {
    enable = true;

    extensions = {
      frecency.enable = true;
      fzf-native = {
        enable = true;
      };
    };

    keymaps = {

      "<leader>/" = {
        action = "live_grep";
        options = {
          desc = "Live Grep";
        };
      };

      "<leader>:" = {
        action = "command_history";
        options = {
          desc = "Command History";
        };
      };

      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "Search Buffers";
        };
      };

      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = "Find Files";
        };
      };

      "<leader>fr" = {
        action = "resume";
        options = {
          desc = "Resume Search";
        };
      };

      "<leader>fp" = {
        action = "oldfiles";
        options = {
          desc = "Past Files";
        };
      };

      "<leader>fs" = {
        action = "grep_string";
        options = {
          desc = "Search for Current Word";
        };
      };

      "<leader>fu" = {
        action = "lsp_references";
        options = {
          desc = "Find references (usage)";
        };
      };

      "<C-p>" = {
        action = "git_files";
        options = {
          desc = "Search git files";
        };
      };

      "<leader>gc" = {
        action = "git_commits";
        options = {
          desc = "Commits";
        };
      };

      "<leader>gs" = {
        action = "git_status";
        options = {
          desc = "Status";
        };
      };

      "<leader>gp" = {
        action = "git_stash";
        options.desc = "Stash";
      };

      "<leader>gb" = {
        action = "git_branches";
        options.desc = "Branches";
      };

      "<leader>sb" = {
        action = "current_buffer_fuzzy_find";
        options = {
          desc = "Buffer";
        };
      };

      "<leader>sh" = {
        action = "help_tags";
        options = {
          desc = "Help pages";
        };
      };

      "<leader>sl" = {
        action = "lsp_document_symbols";
        options = {
          desc = "Lsp Symbols";
        };
      };

      "<leader>sk" = {
        action = "keymaps";
        options = {
          desc = "Keymaps";
        };
      };

      "<leader>sq" = {
        action = "quickfix";
        options = {
          desc = "Quickfix";
        };
      };

      "<leader>sp" = {
        action = "quickfixhistory";
        options = {
          desc = "Quickfix History";
        };
      };

      "<leader>sm" = {
        action = "marks";
        options = {
          desc = "Jump to Mark";
        };
      };

      "<leader>sc" = {
        action = "colorscheme";
        options = {
          desc = "Colorscheme Picker";
        };
      };
    };
  };
  extraConfigLua = ''
    require("telescope").setup {
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
    }
  '';
}
