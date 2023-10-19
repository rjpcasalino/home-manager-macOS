{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "rjpc";
  home.homeDirectory = "/Users/rjpc";
  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Darwin stuff
  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;

  home.packages = [
    pkgs.cowsay
    pkgs.nixpkgs-fmt
    pkgs.neofetch
    pkgs.ripgrep
  ];

  home.file = { };
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # git #
  programs.git = {
    enable = true;
    userName = "rjpc";
    userEmail = "rjpc@rjpc.net";
    aliases = {
      a = "add";
      c = "commit";
      d = "diff";
      f = "fetch";
      s = "status";
      l = "log --graph --decorate --pretty=oneline --abbrev-commit";
      p = "push";
    };
  };
  # #

  # Shells #

  # zsh #
  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    "..." = "cd ../..";
    "g" = "git";
  };
  programs.zsh.initExtra =
    ''
      export BASH_SILENCE_DEPRECATION_WARNING=1
      export GIT_PS1_SHOWDIRTYSTATE=1
      export GIT_PS1_SHOWSTASHSTATE=1
      export GIT_PS1_SHOWCOLORHINTS=1
      export GIT_PS1_SHOWUPSTREAM="auto"
      setopt PROMPT_SUBST
      autoload -U colors && colors
      source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
      export PS1='%F{magenta}%n%f %B%F{blue}%~ $(__git_ps1 "(%s) ")%b%f%# '
    '';
  # #

  # vim & vscode #
  # NOTE: macOS programs.vim.packageConfigurable = pkgs.vim-darwin
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim-darwin;
    settings = {
      background = "light";
      mouse = "a";
      number = true;
    };
    # TODO: autocmd for spell
    extraConfig = ''
      set spell
    '';
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      ms-azuretools.vscode-docker
      ms-vscode.makefile-tools
    ];
  };
  # #
}
