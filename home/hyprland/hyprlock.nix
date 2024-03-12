{ inputs, ... }:
{
  imports = [
    inputs.hyprlock.homeManagerModules.default
  ];

  programs.hyprlock = {
    enable = true;
    general = { };

    backgrounds = [ { path = "${./wallpapers/cat-leaves.png}"; } ];
    input-fields = [
      {
        placeholder_text = "";
        check_color = "rgb(250, 179, 135)";
        fail_color = "rgb(243, 139, 168)";
        inner_color = "rgb(30, 30, 46)";
        outer_color = "rgb(166, 227, 161)";
        font_color = "rgb(205, 214, 244)";
        fail_text = "";
      }
    ];
    labels = [
      {
        text = "$TIME";
        color = "rgb(166, 227, 161)";
        font_size = 70;
        font_family = "JetBrainsMono Nerd Font";
        position = {
          y = 200;
        };
      }
      {
        text = "$USER";
        color = "rgb(166, 227, 161)";
        font_size = 20;
        font_family = "JetBrainsMono Nerd Font";
        position = {
          y = 70;
        };
      }
    ];
  };
}
