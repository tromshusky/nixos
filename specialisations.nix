{...}: {
  specialisation = {
    budgie.configuration.imports = [./budgie.nix];
    cinnamon.configuration.imports = [./cinnamon.nix];
    enlightenment.configuration.imports = [./enlightenment.nix];
    gnome-full.configuration.imports = [./gnome.nix];
    hyprland.configuration.imports = [./hyprland.nix];
    pantheon.configuration.imports = [./pantheon.nix];
    plasma6.configuration.imports = [./plasma6.nix];
    xfce.configuration.imports = [./xfce.nix];
  };
}