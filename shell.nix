{ pkgs ? import <nixpkgs> {} }:

(
  pkgs.buildFHSUserEnv {
    name = "openrs2-natives";
    targetPkgs = pkgs: (
      with pkgs; [
        gcc
        jdk11
        libGL.dev
        maven
        xorg.libX11.dev
        xorg.libXt.dev
        xorg.xorgproto
      ]
    );
  }
).env
