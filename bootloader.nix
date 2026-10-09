let
    updatescript = ''
        set -euo pipefail
        uki=$(nix build /etc/nixos#nixosConfigurations.nixos.config.system.build.{uki,toplevel} --no-write-lock-file --print-out-paths --out-link /nix/var/nix/gcroots/next-system | head -n1)/nixos.efi &&
        cp $uki /boot/efi/boot/NIXOS.EFI
    '';
    scriptfile = lib.mkForce (pkgs.writeScriptBin "nixos-rebuild" updatescript);
in
{
    system.build.nixos-rebuild = scriptfile;
    boot.loader.external.enable = true;
    boot.loader.external.installHook = scriptfile;
}