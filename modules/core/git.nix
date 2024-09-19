{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Simão Sanguinho";
    userEmail = "simao.sanguinho@rnl.tecnico.ulisboa.pt";
    extraConfig = {
      color.ui = true;
      pull.rebase = true;
      init.defaultBranch = "main";
      core.editor = "nano";
    };
    diff-so-fancy = { enable = true; };
  };
}