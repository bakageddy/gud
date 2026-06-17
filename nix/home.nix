{ pkgs, zen-browser, ... }:
{                                                                                                                                                              
	home.username = "dinesh-24010"; # CHANGE THIS TO YOUR USERNAME                                                                                               
	home.homeDirectory = "/home/dinesh-24010"; # CHANGE THIS TO YOUR HOME DIRECTORY                                                                              
																																								 
	home.packages = with pkgs; [                                                                                                                                 
		ripgrep
		fd
		htop
		zen-browser.packages.x86_64-linux.default
	];                                                                                                                                                           
	programs.home-manager.enable = true;                                                                                                                         
	home.stateVersion = "23.11";                                                                                                                                 
}     
