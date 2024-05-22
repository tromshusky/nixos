{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
    nixosConfigurations."macbookpro7-1" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration-mbp71.nix ];
    };
  };
}



