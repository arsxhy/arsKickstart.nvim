-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'mfussenegger/nvim-jdtls' },

  -- Cord.Nvim (neovim discord rich presence)
  -- Docs = https://github.com/vyfor/cord.nvim
  {
    'vyfor/cord.nvim',
    build = ':Cord update',
    opts = function()
      return {
        display = {
          theme = 'default',
          flavor = 'accent',
          swap_fields = false,
          swap_icons = false,
        },
        timestamp = {
          enabled = true,
          reset_on_idle = true,
          reset_on_change = false,
        },
        text = {
          viewing = function(opts)
            return string.format('Viewing %s', opts.filename)
          end,
          editing = function(opts)
            local total_lines = vim.fn.line '$'
            return string.format('Editing %s - Line %s out of %s', opts.filename, opts.cursor_line, total_lines)
          end,
          workspace = function(opts)
            return string.format('Workspace: %s', opts.workspace)
          end,
        },
        buttons = {
          {
            label = function(opts)
              return opts.repo_url and 'View Repository'
            end,
            url = function(opts)
              return opts.repo_url or 'https://github.com/arsxhy/'
            end,
          },
        },
        hooks = {
          post_activity = function(opts, activity)
            local version = vim.version()
            activity.assets.small_text = string.format('Neovim %s.%s.%s', version.major, version.minor, version.patch)
          end,
        },
        plugins = {
          -- 'cord.plugins.diagnostics', -- Enable diagnostics plugin with default settings

          -- ['cord.plugins.diagnostics'] = { -- Configure diagnostics plugin
          --   scope = 'buffer', -- Set scope to 'workspace' instead of default 'buffer'
          --   severity = vim.diagnostic.severity.WARN, -- Show warnings and above
          -- },
        },
        advanced = {
          workspace = {
            root_markers = {
              '.git',
              '.hg',
              '.svn',
            },
            limit_to_cwd = false,
          },
        },
        -- in cord's cfg
        log_level = 'info',
      }
    end,
  },
  -- https://github.com/brenoprata10/nvim-highlight-colors
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      enable_tailwind = true,
    },
  },
  -- https://github.com/nvimdev/dashboard-nvim
  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    priority = 999,
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
        theme = 'hyper', -- theme is doom and hyper default is hyper
        disable_move = false, -- default is false disable move keymap for hyper
        shortcut_type = 'letter', -- shortcut type 'letter' or 'number'
        shuffle_letter = false, -- default is false, shortcut 'letter' will be randomize, set to false to have ordered letter
        -- letter_list = 'a-z',       -- default is a-z, excluding j and k
        change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
        config = { -- config used for theme
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = '󰒲  Lazy', group = '@property', action = 'Lazy home', key = 'l' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Mason',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
          hide = {
            statusline = true, -- hide statusline default is true
            tabline = true, -- hide the tabline
            winbar = false, -- hide winbar
          },
          preview = {
            -- command = false, -- preview command
            -- file_path = true, -- preview file path
            -- file_height = true, -- preview file height
            -- file_width = true, -- preview file width
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  -- https://github.com/CRAG666/betterTerm.nvim
  {
    'CRAG666/betterTerm.nvim',
    keys = {
      {
        mode = { 'n', 't' },
        '<C-`>',
        function()
          require('betterTerm').open()
        end,
        desc = 'Open BetterTerm 0',
      },
      {
        mode = { 'n', 't' },
        '<C-1>',
        function()
          require('betterTerm').open(1)
        end,
        desc = 'Open BetterTerm 1',
      },
      {
        '<leader>`t',
        function()
          require('betterTerm').select()
        end,
        desc = 'Select terminal',
      },
    },
    opts = {
      position = 'bot',
      size = 25,
      jump_tab_mapping = '<A-$tab>',
    },
  },
}
