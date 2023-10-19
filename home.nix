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
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gs = "git status";
      glog = "git log --graph --decorate --pretty=oneline --abbrev-commit";
    };
  };
  # #

  # Shells #
  # TODO: remove bash? 
  # macOS barks at some of these settings
  programs.bash.enable = false;
  programs.bash.historyIgnore = [ "ls" "cd" "exit" ];
  programs.bash.shellAliases =
    {
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  programs.bash.enableCompletion = true;
  programs.bash.shellOptions = [
    "histappend"
    "checkwinsize"
    "extglob"
    "-globstar"
    "-checkjobs"
  ];
  programs.bash.initExtra =
    ''
      source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
      export PS1='\n\[\e[38;5;200m\]\u\[\e[0m\] on \[\e[38;5;27m\]\H\[\e[0m\] in [\w]$(__git_ps1 " \[\e[38;5;207m\]on\[\e[0m\] (%s)") '
    '';
  # #

  # zsh #
  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    "..." = "cd ../..";
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
  programs.vim.enable = true;
  programs.vim.packageConfigurable = pkgs.vim-darwin;
  programs.vim.settings = {
    background = "light";
    mouse = "a";
    number = true;
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
