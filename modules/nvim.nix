{ pkgs, lib, config, inputs, ... }: {
  options = {
    m_nixvim.enable = 
      lib.mkEnableOption "enables nixvim module configuration";
  };
  
  config = lib.mkIf config.m_nixvim.enable {
    programs.nixvim = {
      enable = true;
      # Utilisez la version unstable de neovim
      package = pkgs.neovim-unstable;
      colorschemes.catppuccin.enable = true;
      
      plugins = {
        lualine.enable = true;
      };
    };
  };
}
