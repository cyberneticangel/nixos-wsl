{ config, pkgs, ... }: {
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "25.11";
    packages = with pkgs; [
      htop
      btop
     ];
  };
  programs.bash = {
   enable = true;
    shellAliases = {
     rebuild = "sudo nixos-rebuild switch";
   };
  };
}
