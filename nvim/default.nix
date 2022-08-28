{ config, pkgs, lib, vimUtils, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
in
{
  nixpkgs.config.allowUnfree = true;
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    # read int the vim config from filesystem
    # this enables syntaxhighlighting when editing those
    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./aerial.lua}
      ${builtins.readFile ./alpha.lua}
      ${builtins.readFile ./autocommands.lua}
      ${builtins.readFile ./autopairs.lua}
      ${builtins.readFile ./bufferline.lua}
      ${builtins.readFile ./cmp.lua}
      ${builtins.readFile ./colorscheme.lua}
      ${builtins.readFile ./comment.lua}
      ${builtins.readFile ./dressing.lua}
      ${builtins.readFile ./fidget.lua}
      ${builtins.readFile ./gitsigns.lua}
      ${builtins.readFile ./impatient.lua}
      ${builtins.readFile ./indentline.lua}
      ${builtins.readFile ./lsp/init.lua}
      ${builtins.readFile ./lsp/clangd.lua}
      ${builtins.readFile ./lualine.lua}
      ${builtins.readFile ./keymaps.lua}
      ${builtins.readFile ./leap.lua}
      ${builtins.readFile ./null-ls.lua}
      ${builtins.readFile ./neo-tree.lua}
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./project.lua}
      ${builtins.readFile ./telescope.lua}
      ${builtins.readFile ./toggleterm.lua}
      ${builtins.readFile ./treesitter.lua}
      ${builtins.readFile ./whichkey.lua}EOF'';
    # install needed binaries here 
    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      tree-sitter
      jq
      curl # rest.nvim
      bat
      ripgrep
      fd
      fzf
      nodejs
      universal-ctags
      python310
      nodePackages.prettier
      stylua
      go
      cargo
      lua
      luajitPackages.luarocks
      php
      php81Packages.composer
      python310Packages.pip
      julia-bin

      # installs different language servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      python310Packages.pygls
      nodePackages.bash-language-server # bashls
      #cmake-language-server                         # cmake
      deno # denols
      nodePackages.diagnostic-languageserver # diagnosticls
      nodePackages.dockerfile-language-server-nodejs # dockerls
      gopls # gopls
      nodePackages.vscode-langservers-extracted # html cssls jsonls
      nodePackages.intelephense # intelephense
      nodePackages.pyright
      black # pyright
      rnix-lsp # rnix
      rust-analyzer # rust_analyzer
      sqls # sqls
      sumneko-lua-language-server # sumneko_lua 
      nodePackages.svelte-language-server # svelte
      nodePackages.tailwindcss # tailwindcss
      texlab # texlab
      nodePackages.typescript
      nodePackages.typescript-language-server # tsserver
      nodePackages.vim-language-server # vimls
      nodePackages.vue-language-server # vuels
    ];
    plugins = with pkgs.vimPlugins; [
      vim2nix
      luasnip
      (plugin "nvim-lua/plenary.nvim")
      (plugin "windwp/nvim-autopairs")
      (plugin "numToStr/Comment.nvim")
      (plugin "JoosepAlviste/nvim-ts-context-commentstring")
      (plugin "kyazdani42/nvim-web-devicons")
      (plugin "kyazdani42/nvim-tree.lua")
      (plugin "nvim-neo-tree/neo-tree.nvim")
      (plugin "akinsho/bufferline.nvim")
      (plugin "moll/vim-bbye")
      (plugin "nvim-lualine/lualine.nvim") # requires nui.nvim, plenary, and nvim-web-devicons
      (plugin "feline-nvim/feline.nvim")
      (plugin "akinsho/toggleterm.nvim")
      (plugin "ahmedkhalf/project.nvim")
      (plugin "lewis6991/impatient.nvim")
      (plugin "lukas-reineke/indent-blankline.nvim")
      (plugin "goolord/alpha-nvim")
      (plugin "folke/which-key.nvim")
      (plugin "ggandor/leap.nvim")
      (plugin "stevearc/aerial.nvim")
#      (plugin "simnalamburt/vim-mundo")
      (plugin "stevearc/dressing.nvim")
      (plugin "j-hui/fidget.nvim")
      (plugin "MunifTanjim/nui.nvim")
      # Colorschemes
      (plugin "folke/tokyonight.nvim")
      (plugin "lunarvim/darkplus.nvim")
      (plugin "fenetikm/falcon")
      (plugin "glepnir/zephyr-nvim")
      (plugin "ray-x/aurora")
      (plugin "nekonako/xresources-nvim")
      (plugin "marko-cerovac/material.nvim")
      (plugin "RRethy/nvim-base16")
      (plugin "EdenEast/nightfox.nvim")
      (plugin "shaunsingh/moonlight.nvim")
      (plugin "bluz71/vim-moonfly-colors")
      (plugin "metalelf0/jellybeans-nvim")
      (plugin "rktjmp/lush.nvim")
      (plugin "pineapplegiant/spaceduck")
      # cmp plugins
      (plugin "hrsh7th/nvim-cmp") # Completion plugin
      (plugin "hrsh7th/cmp-buffer") # buffer completions
      (plugin "hrsh7th/cmp-path") # path completions
      (plugin "saadparwaiz1/cmp_luasnip") # snippet completions
      (plugin "hrsh7th/cmp-nvim-lsp")
      (plugin "hrsh7th/cmp-nvim-lua")

      # snippets
      (plugin "rafamadriz/friendly-snippets") # a bunch of snippets to use

      # LSP
      (plugin "neovim/nvim-lspconfig") # enable LSP
      (plugin "williamboman/nvim-lsp-installer") # simple to use language server installer
      (plugin "jose-elias-alvarez/null-ls.nvim") # for formatters and linters
      (plugin "Maan2003/lsp_lines.nvim") # lsp diagnostics shown in file
      (plugin "williamboman/mason.nvim")
      (plugin "williamboman/mason-lspconfig.nvim")

      # Telescope
      (plugin "nvim-telescope/telescope.nvim")

      # Treesitter
      (plugin "nvim-treesitter/nvim-treesitter")

      # Git
      (plugin "lewis6991/gitsigns.nvim")

      # Language Servers 
      (plugin "p00f/clangd_extensions.nvim")
    ];
  };
}
