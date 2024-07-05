{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.rockchip.url = "github:nabam/nixos-rockchip";

  # Use cache with packages from nabam/nixos-rockchip CI.
  nixConfig = {
    extra-substituters = [ "https://nabam-nixos-rockchip.cachix.org" ];
    extra-trusted-public-keys = [
      "nabam-nixos-rockchip.cachix.org-1:BQDltcnV8GS/G86tdvjLwLFz1WeFqSk7O9yl+DR0AVM"
    ];
  };

  outputs = { self, nixpkgs, rockchip, home-manager, ... }@attrs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        ./myconf.nix
        {
          nixpkgs.config.allowUnfree = true;
	  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
             "bes2600-firmware-aarch64-unknown-linux-gnu"
           ];
          boot.kernelPackages =
            rockchip.legacyPackages."x86_64-linux".kernel_linux_6_9_pinetab;
          hardware.firmware = [ rockchip.packages."x86_64-linux".bes2600 ];
        }
      ];
    };
  };
}
