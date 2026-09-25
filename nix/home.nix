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
    # (config.lib.nixGL.wrap quickshell)
	# performance of these programs are better when you compile them yourself
	(config.lib.nixGL.wrap noctalia)
	(config.lib.nixGL.wrap niri)
    thunar
    htop
    (config.lib.nixGL.wrap zen-browser.packages.x86_64-linux.default)
	(config.lib.nixGL.wrap eclipse-mat)
    firefox

    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_djvu

    foot
    (config.lib.nixGL.wrap kitty)
	(config.lib.nixGL.wrap ghostty)
	(config.lib.nixGL.wrap mpv)
	(config.lib.nixGL.wrap hyprland)
    helix

    jetbrains-mono
	nerd-fonts.lilex
	nerd-fonts.geist-mono
	ioskeley-mono.term-nf

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
