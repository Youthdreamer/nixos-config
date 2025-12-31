{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_24
    pnpm_9

    rustup

    go

    python314
    uv

    gcc15
    gdb
    pkg-config
    cmake
  ];
}
