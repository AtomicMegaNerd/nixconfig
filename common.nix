{ config, pkgs, ... }:
let
  pkgsUnstable = import <unstable> { };
in
{
  home.username = "rcd";
  home.homeDirectory = "/home/rcd";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    wget
    curl
    fzf
    ripgrep
    fd
    exa
    bat
    du-dust
    duf
    htop
    neofetch
    git
    gcc
    gnumake
    zip
    unzip
    go
    jq
    python311
    tldr
    grc
    procs
    just
    exercism
    poetry
    ruff
    yarn
    go-tools
  ];

  programs.neovim = {
    enable = true;
    package = pkgsUnstable.neovim-unwrapped;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgsUnstable; [
      # Language servers
      pyright
      gopls
      sumneko-lua-language-server
      rnix-lsp
      ruff
      rust-analyzer
      yaml-language-server
      nodePackages.bash-language-server
      nodePackages.typescript-language-server

      # null-ls sources
      black
      gofumpt
      mypy
      shellcheck
      stylua
      nixpkgs-fmt
      nodePackages.prettier
      nodePackages.markdownlint-cli
    ];

    plugins = [
      pkgsUnstable.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  programs.bash = {
    enable = false;
  };

  programs.fish =
    {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        ### Nightfox theme ###
        set -l foreground cdcecf
        set -l selection 223249
        set -l comment 526176
        set -l red c94f6d
        set -l orange f4a261
        set -l yellow dbc074
        set -l green 81b29a
        set -l purple 9d79d6
        set -l cyan 63cdcf
        set -l pink d67ad2

        # Syntax Highlighting Colors
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $pink
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_error $red
        set -g fish_color_param $purple
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_math --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $pink
        set -g fish_color_autosuggestion $comment

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $commentc

        # omf configuration 
        set -x VIRTUAL_ENV_DISABLE_PROMPT 1
        set -g theme_nerd_fonts yes
        set -g theme_color_scheme nord
        set -g theme_newline_cursor yes
        set -g theme_newline_prompt '% ' 
      '';

      shellAliases = {
        ls = "exa";
        ll = "exa -lah";
        df = "duf";
        cat = "bat --paging=never --style=plain";

        # Directory aliases
        ch = "cd ~";
        csrc = "cd ~/Code";
        cr = "cd ~/Code/Rust/";
        cg = "cd ~/Code/Go/";
        cpy = "cd ~/Code/Python/";
        ce = "cd ~/Code/Exercism/";
        cgo = "cd ~/Code/Go/";
        cdot = "cd ~/Code/Configs/dotfiles/";

        # Just use ripgrep
        grep = "rg";

        # Convenient shortcuts
        vconf = "nvim $HOME/.config/nvim/init.lua";
        fconf = "nvim $HOME/.config/fish/config.fish";
        aconf = "nvim $HOME/.config/alacritty/alacritty.yml";
        nconf = "nvim $HOME/.config/nixpkgs/home.nix";

        tl = "tmux list-sessions";
        ta = "tmux attach";
        tk = "tmux kill-session";
        tka = "tmux kill-server";
      };

      functions =
        {
          tn = "tmux new -s (basename (eval pwd))";
        };

      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "bobthefish";
          src = pkgs.fetchFromGitHub
            {
              owner = "oh-my-fish";
              repo = "theme-bobthefish";
              rev = "2dcfcab653ae69ae95ab57217fe64c97ae05d8de";
              sha256 = "jBbm0wTNZ7jSoGFxRkTz96QHpc5ViAw9RGsRBkCQEIU=";
            };
        }
      ];
    };


  programs.tmux = {
    enable = true;
    prefix = "C-a";
    extraConfig = ''
      		# Nightfox Theme for tmux
      		################################################################
      		set -g mode-style "fg=#719cd6,bg=#3b4261"
      		set -g message-style "fg=#719cd6,bg=#3b4261"
      		set -g message-command-style "fg=#719cd6,bg=#3b4261"
      		set -g pane-border-style "fg=#3b4261"
      		set -g pane-active-border-style "fg=#719cd6"
      		set -g status "on"
      		set -g status-justify "left"
      		set -g status-style "fg=#719cd6,bg=#131A24"
      		set -g status-left-length "100"
      		set -g status-right-length "100"
      		set -g status-left-style NONE
      		set -g status-right-style NONE
      		set -g status-left "#[fg=#393b44,bg=#719cd6,bold] #S #[fg=#719cd6,bg=#131A24,nobold,nounderscore,noitalics]???"
      		set -g status-right "#[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]???#[fg=#719cd6,bg=#131A24] #{prefix_highlight} #[fg=#3b4261,bg=#131A24,nobold,nounderscore,noitalics]???#[fg=#719cd6,bg=#3b4261] %Y-%m-%d ??? %H:%M #[fg=#719cd6,bg=#3b4261,nobold,nounderscore,noitalics]???#[fg=#393b44,bg=#719cd6,bold] #h "
      		setw -g window-status-activity-style "underscore,fg=#AEAFB0,bg=#131A24"
      		setw -g window-status-separator ""
      		setw -g window-status-style "NONE,fg=#AEAFB0,bg=#131A24"
      		setw -g window-status-format "#[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]???#[default] #I ??? #W #F #[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]???"
      		setw -g window-status-current-format "#[fg=#131A24,bg=#3b4261,nobold,nounderscore,noitalics]???#[fg=#719cd6,bg=#3b4261,bold] #I ??? #W #F #[fg=#3b4261,bg=#131A24,nobold,nounderscore,noitalics]???"

      		# Other tmux settings
      		################################################################

      		# Force Tmux to support more colors
      		set  -g default-terminal "screen-256color"
      		set-option -sa terminal-overrides ",xterm-256color:RGB"

      		# Enable Mouse
      		setw -g mouse on

      		# Neovim recommended
      		set-option -sg escape-time 10
      		set-option -g focus-events on

      		# remap prefix from C-b to C-a
      		unbind C-b
      		set-option -g prefix C-a
      		bind-key C-a send-prefix

      		# Set the base index to something sensible
      		set -g base-index 1
      	  '';
  };

  xdg.configFile = {
    nvim = {
      source = ./nvim;
      target = "nvim";
    };
  };

  programs.git = {
    enable = true;
    userName = "Chris Dunphy";
    userEmail = "chris@megaparsec.ca";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # Some weird bug
  manual.manpages.enable = false;
  manual.html.enable = false;
  manual.json.enable = false;
}
