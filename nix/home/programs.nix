{ ... }:

{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };

      initExtra = ''
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/run/current-system/sw/bin:$PATH"

        export TMUX_PLUGIN_MANAGER_PATH="~/.tmux/plugins"
      '';

      shellAliases = {
        "ls" = "eza -la";
        "cat" = "ccat";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    ssh = {
      enable = true;
      extraConfig = ''
        Host github.com
          AddKeysToAgent yes
          UseKeychain yes
          IdentityFile ~/.ssh/id_ed25519
      '';
    };
  };
}
