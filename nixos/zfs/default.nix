{ ... }:
{
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
    autoSnapshot = {
      enable = true;
    };
    trim = {
      enable = true;
      interval = "weekly";
    };
  };
}
