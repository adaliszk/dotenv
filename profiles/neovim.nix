{ pkgs, ... }:

pkgs.buildEnv {
  name = "neovim";
  paths = with pkgs; [
    neovim
    vimPlugins.fleet-theme-nvim
    #  vimPlugins.nvim-numbertoggle
    #  vimPlugins.neovim-fuzzy
    #  vimPlugins.neovim-trunk
  ];
}
