{...}: {
  specialisation = {
#    budgie.configuration.imports = [./desktops/budgie.nix];
#    cinnamon.configuration.imports = [./desktops/cinnamon.nix];
#    enlightenment.configuration.imports = [./desktops/enlightenment.nix];
    gnome-full.configuration.imports = [./desktops/gnome.nix];
    hyprland.configuration.imports = [./desktops/hyprland.nix];
#    pantheon.configuration.imports = [./desktops/pantheon.nix];
#    plasma6.configuration.imports = [./desktops/plasma6.nix];
#    xfce.configuration.imports = [./desktops/xfce.nix];
  };
}
