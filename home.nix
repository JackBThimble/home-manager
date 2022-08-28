{ config, pkgs, ... }:

{
  imports = [
    ./nvim
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  nixpkgs.config.allowUnfree = true; 
  home.packages = with pkgs; [
    gcc
    go
    php
    php81Packages.composer
    lapce
    gnvim
  ];
  programs.kitty.enable = true;
  programs.kitty.font.package = pkgs.meslo-lgs-nf;
  programs.kitty.font.name = "Meslo LGS NF Regular";
  programs.kitty.extraConfig = ''
    background #0f111b
  foreground #ecf0c1
  cursor #ecf0c1
  selection_background #686f9a
  color0 #000000
  color8 #686f9a
  color1 #e33400
  color9 #e33400
  color2 #5ccc96
  color10 #5ccc96
  color3 #b3a1e6
  color11 #b3a1e6
  color4 #00a3cc
  color12 #00a3cc
  color5 #f2ce00
  color13 #f2ce00
  color6 #7a5ccc
  color14 #7a5ccc
  color7 #686f9a
  color15 #f0f1ce
  selection_foreground #ffffff
  '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
