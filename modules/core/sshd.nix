{ lib, sshKeys, username, ... }: {
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [ "/var/lib/openssh-server/%u" "/home/%u/.ssh/authorized_keys" ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users.sanguinho.openssh.authorizedKeys.keys = sshKeys;
}
