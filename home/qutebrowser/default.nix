{ ... }:
{
  programs.qutebrowser = {
    enable = true;

    settings = {
      content = {
        canvas_reading = false;
        
        cookies = {
          accept = "no-3rdparty";
          store = false;
        };

        pdfjs = true;

        private_browsing = true;
      };
    };

    extraConfig = ''
      ${builtins.readFile ./catppuccin.py}
    '';
  };
}
