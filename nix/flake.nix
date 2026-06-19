{
  description = "My Snow Flake with homemanager";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      username = "dinesh-24010";
      system = "x86_64-linux";
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit system username zen-browser; };
        modules = [ ./home.nix ];
      };
    };
}
