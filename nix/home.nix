{
  pkgs,
  zen-browser,
  programs,
  ...
}:
{
  home.username = "dinesh-24010"; # CHANGE THIS TO YOUR USERNAME
  home.homeDirectory = "/home/dinesh-24010"; # CHANGE THIS TO YOUR HOME DIRECTORY
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--no-sandbox"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium;
    #     commandLineArgs = [
    #   "--no-sandbox"
    #   "--enable-features=UseOzonePlatform"
    #   "--ozone-platform=wayland"
    # ];
  };

  home.packages = with pkgs; [

    thunar
    htop
    zen-browser.packages.x86_64-linux.default

    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_djvu

    foot
    ghostty

    ioskeley-mono.normal-unhinted
	jetbrains-mono
	fragment-mono

    # bruno-cli
    duckdb
    sqlite
    turso

    ripgrep
    fd

	pnpm
	nodejs
	jdk21
	jre21
	deno
	zig
	go
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
