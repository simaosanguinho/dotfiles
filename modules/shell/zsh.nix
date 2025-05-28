{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      u = "sudo nixos-rebuild switch";
      up = "sudo nixos-rebuild switch --upgrade";
      cd = "z";
      ":q" = "exit";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "aliases" ];
      theme = "robbyrussell";
    };
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
  };
}