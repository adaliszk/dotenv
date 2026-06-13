{ pkgs, ... }:

pkgs.buildEnv {
  name = "kubeadmin";
  paths = with pkgs; [
    kubectl
    k9s
  ];
}
