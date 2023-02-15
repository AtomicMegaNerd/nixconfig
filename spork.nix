{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      Host *
              IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.fish = {
    shellInit = ''
      set -gx NIX_PATH $NIX_PATH:$HOME/.nix-defexpr/channels
      set -gx GOROOT /nix/store/p66a1hlyf342rdrymb14nqcfhnkz7mqc-home-manager-path/share/go
      set -gx GOPATH $HOME/Code/Go
    '';
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  fonts.fontconfig.enable = true;

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
      cursor = {
        style = {
          shape = "Block";
          blinking = "Always";
        };
      };
      mouse_bindings = [
        { mouse = "Right"; action = "Paste"; }
        { mouse = "Left"; action = "Copy"; }
      ];
      window = {
        decorations = "none";
        padding = {
          x = 3;
          y = 3;
        };
        opacity = 0.97;
      };
      colors = {

        primary = {
          background = "0x192330";
          foreground = "0xcdcecf";
        };
        normal = {
          black = "0x393b44";
          red = "0xc94f6d";
          green = "0x81b29a";
          yellow = "0xdbc074";
          blue = "0x719cd6";
          magenta = "0x9d79d6";
          cyan = "0x63cdcf";
          white = "0xdfdfe0";
        };
        # Bright colors
        bright = {
          black = "0x575860";
          red = "0xd16983";
          green = "0x8ebaa4";
          yellow = "0xe0c989";
          blue = "0x86abdc";
          magenta = "0xbaa1e2";
          cyan = "0x7ad4d6";
          white = "0xe4e4e5";
        };
        indexed_colors = [
          { index = 16; color = "0xf4a261"; }
          { index = 17; color = "0xd67ad2"; }
        ];
      };
    };
  };
}
