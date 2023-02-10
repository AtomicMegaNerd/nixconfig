{ config, pkgs, ... }:

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
    rustup
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

    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Language servers
      pyright
      gopls
      nodePackages.bash-language-server
      sumneko-lua-language-server
      rnix-lsp
      ruff

      # null-ls sources
      black
      gofumpt
      mypy
      nodePackages.prettier
      nodePackages.markdownlint-cli
      shellcheck
      stylua
      nixpkgs-fmt
    ];
  };

  programs.bash = {
    enable = false;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
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

  fonts.fontconfig.enable = true;

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
      		set -g status-left "#[fg=#393b44,bg=#719cd6,bold] #S #[fg=#719cd6,bg=#131A24,nobold,nounderscore,noitalics]"
      		set -g status-right "#[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#131A24] #{prefix_highlight} #[fg=#3b4261,bg=#131A24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#719cd6,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#393b44,bg=#719cd6,bold] #h "
      		setw -g window-status-activity-style "underscore,fg=#AEAFB0,bg=#131A24"
      		setw -g window-status-separator ""
      		setw -g window-status-style "NONE,fg=#AEAFB0,bg=#131A24"
      		setw -g window-status-format "#[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]"
      		setw -g window-status-current-format "#[fg=#131A24,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#131A24,nobold,nounderscore,noitalics]"

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

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
        size = 18;
      };
    };
  };
}
