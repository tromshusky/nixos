{

#  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
#  inputs.home-manager.url = github:nix-community/home-manager;
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
  inputs.home-manager.url = github:nix-community/home-manager/release-24.05;

  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ noflake/configuration.nix ];
    };
    nixosConfigurations."macbookpro7-1" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ noflake/configuration-mbp71.nix ];
    };
    nixosConfigurations."pinetab2" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [ noflake/configuration-pt2.nix ];
    };
  };
}



