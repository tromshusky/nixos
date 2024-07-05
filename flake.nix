{
  description = "Build example NixOS image for pt2";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
#    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    rockchip = { url = "github:nabam/nixos-rockchip"; };
  };

  # Use cache with packages from nabam/nixos-rockchip CI.
  nixConfig = {
    extra-substituters = [ "https://nabam-nixos-rockchip.cachix.org" ];
    extra-trusted-public-keys = [
      "nabam-nixos-rockchip.cachix.org-1:BQDltcnV8GS/G86tdvjLwLFz1WeFqSk7O9yl+DR0AVM"
    ];
  };

  outputs = { self, ... }@inputs:
    let

      pkgsUnstable = system:
        import inputs.nixpkgs {
          inherit system;
          crossSystem.system = "aarch64-linux";
          config.allowUnfree = true; # for arm-trusted-firmware
        };

      bes2600Firmware = system:
        (pkgsUnstable system).callPackage ./bes2600-firmware.nix { };

#      asd = inputs.nixpkgs.pkgs.callPackage ./bes2600-firmware.nix ;

      osConfig = buildPlatform:
        inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./configuration.nix
            {
              # Use cross-compilation for uBoot and Kernel.
              nixpkgs.config.allowBroken = true;
              nixpkgs.config.allowUnfree = true;
#              hardware.firmware = [ (bes2600Firmware "x86_64-linux") ];
              hardware.firmware = [ (bes2600Firmware "aarch64-linux") ];
              boot.kernelPackages =
                inputs.rockchip.legacyPackages.${buildPlatform}.kernel_linux_6_9_pinetab;
            }
          ];
        };
    in {
      # Set buildPlatform to "x86_64-linux" to benefit from cross-compiled packages in the cache.
      nixosConfigurations.pt2 = osConfig "x86_64-linux";

      # Or use configuration below to compile kernel and uBoot on device.
      # nixosConfigurations.quartz64 = osConfig "aarch64-linux";
    } // inputs.utils.lib.eachDefaultSystem (system: {
      # Set buildPlatform to "x86_64-linux" to benefit from cross-compiled packages in the cache.
      packages.image = (osConfig "x86_64-linux").config.system.build.sdImage;

      # Or use configuration below to cross-compile kernel and uBoot on the current platform.
      # packages.image = (osConfig system).config.system.build.sdImage;

      packages.default = self.packages.${system}.image;
    });
}
