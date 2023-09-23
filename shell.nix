{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "openrs2-natives";
  packages = with pkgs; [
    gcc
    jdk11
    libglvnd.dev
    maven
    xorg.libX11.dev
    xorg.libXt.dev
    xorg.xorgproto
  ];
}
