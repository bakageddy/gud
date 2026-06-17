{ pkgs }:
{                                                                                                                                                              
	home.username = "dinesh-24010"; # CHANGE THIS TO YOUR USERNAME                                                                                               
	home.homeDirectory = "/home/dinesh-24010"; # CHANGE THIS TO YOUR HOME DIRECTORY                                                                              
																																								 
	home.packages = with pkgs; [                                                                                                                                 
	  ripgrep                                                                                                                                                    
	  fd                                                                                                                                                         
	];                                                                                                                                                           
																																								 
	programs.home-manager.enable = true;                                                                                                                         
																																								 
	home.stateVersion = "23.11";                                                                                                                                 
}     
