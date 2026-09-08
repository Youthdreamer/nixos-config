{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
  documentation = {
    enable = true;
    man = {
      enable = true;
      cache.enable = true;
      man-db = {
        enable = true;
      };
    };
  };
}
