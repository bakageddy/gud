{ pkgs, zen-browser, ... }:
{                                                                                                                                                              
	home.username = "dinesh-24010"; # CHANGE THIS TO YOUR USERNAME                                                                                               
	home.homeDirectory = "/home/dinesh-24010"; # CHANGE THIS TO YOUR HOME DIRECTORY                                                                              
																																								 
	home.packages = with pkgs; [                                                                                                                                 
		ripgrep
		fd
		htop
		ungoogled-chromium
		zen-browser.packages.x86_64-linux.default
		foot
		ghostty
		go
		zig
		deno
		nodejs
		pnpm
		openjdk
		jre
		scala
	];                                                                                                                                                           
	programs.home-manager.enable = true;                                                                                                                         
	home.stateVersion = "23.11";                                                                                                                                 
}     
