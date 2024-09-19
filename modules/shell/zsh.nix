{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      u = "sudo nixos-rebuild switch";
      cd = "z";
      ":q" = "exit";
      ls = "ls && echo 'ඞ'";
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