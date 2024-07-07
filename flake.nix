{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  inputs.home-manager.url = "github:nix-community/home-manager";
#  inputs.rockchip.url = "github:nabam/nixos-rockchip";

  # Use cache with packages from nabam/nixos-rockchip CI.
  nixConfig = {
    extra-substituters = [ "https://nabam-nixos-rockchip.cachix.org" ];
    extra-trusted-public-keys = [
      "nabam-nixos-rockchip.cachix.org-1:BQDltcnV8GS/G86tdvjLwLFz1WeFqSk7O9yl+DR0AVM"
    ];
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
      ];
    };
  };
}
