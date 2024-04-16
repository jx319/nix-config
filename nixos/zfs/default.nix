{ ... }:
{
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
    autoSnapshot = {
      enable = true;
      interval = "daily";
    };
    trim = {
      enable = true;
      interval = "weekly";
    };
  };
}
