{
  description = "Sanguinho's NixOS configuration";

inputs = {
    # The nixpkgs version to use.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # The home-manager version to use.
    home = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      inherit (builtins) listToAttrs attrNames readDir filter;
      inherit (lib) hasSuffix;
      inherit (inputs.nixpkgs.lib.filesystem) listFilesRecursive;
      myLib = (import ./lib { inherit lib; }).myLib;

      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1lwuhiBZjUIzFikFCrzyp1jppOZSvlyc1/JZDvvqgD simao.sanguinho@gmail.com"
      ];

      # Imports every nix module from a directory, recursively.
      mkModules = path: filter (hasSuffix ".nix") (listFilesRecursive path);

      modules = myLib.rakeLeaves ./modules;

      # Imports every host defined in a directory.
      mkHosts = dir:
        listToAttrs (map (name: {
          inherit name;
          value = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs modules sshKeys; };
            modules = [
              { networking.hostName = name; }
              { nixpkgs.config.allowUnfree = true; }
              modules.core.sshd
              inputs.home.nixosModules.home-manager
              { home-manager = { useGlobalPkgs = true; }; }
            ] ++ (mkModules "${dir}/${name}");
          };
        }) (attrNames (readDir dir)));
    in { nixosConfigurations = mkHosts ./hosts; };
}