{ pkgs, ... }: 
{
  services.dunst = {
    enable = true;
    settings = {    
      global = {
        separator_color = "frame";

        follow = "mouse";
        width = 400;
        height = 150;
        origin = "top-center";
        offset = "0x0";
        font = "JetBrainsMono Nerd Font 16";
        corner_radius = 10;      
        };
        
      urgency_low = {
        frame_color = "#45475a";
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        frame_color = "#a6e3a1";
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
      };
    };
  };
}
