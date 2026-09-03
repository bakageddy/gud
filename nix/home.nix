{
  config,
  pkgs,
  zen-browser,
  nixgl,
  programs,
  ...
}:
{
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";

  home.username = "dinesh-24010"; # CHANGE THIS TO YOUR USERNAME
  home.homeDirectory = "/home/dinesh-24010"; # CHANGE THIS TO YOUR HOME DIRECTORY
  # programs.chromium = {
  #   enable = true;
  #   package = pkgs.ungoogled-chromium;
  #   commandLineArgs = [
  #     "--no-sandbox"
  #     "--enable-features=UseOzonePlatform"
  #     "--ozone-platform=wayland"
  #   ];
  # };

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium;
  };

  home.packages = with pkgs; [
    (config.lib.nixGL.wrap quickshell)
	(config.lib.nixGL.wrap kitty)
    thunar
    htop
    zen-browser.packages.x86_64-linux.default
    firefox

    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_djvu

    foot
    ghostty
    helix

    jetbrains-mono
	nerd-fonts.roboto-mono
	nerd-fonts.lilex

    # bruno-cli
    duckdb
    sqlite
    turso

    ripgrep
    fd
    jq
	mpdris2

    pnpm
	gradle
    nodejs
	eclipse-mat
	visualvm
    jdk21
    jre
    deno
    go
    ghc
    scala
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "26.11";
}
