{
  outputs = { self, nixpkgs, ... }@attrs: {
    confi = {
      import = ./configuration.nix;
    };
  };
}

