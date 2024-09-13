{ lib, sshKeys, username, ... }: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users.sanguinho.openssh.authorizedKeys.keys = sshKeys;
}