{ lib, config, pkgs, ...}: 
{
  programs.wofi = {
    enable = true;
    settings = {
      width = "30%";
      height = "40%";
      prompt = "";
    };
    style = ''
      #window {
        border-radius: 10;
        border-color: #a6e3a1;
        border-width: 2px;
        }
    '';
  };
}
