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
    pkgs.nixpkgs-fmt
    pkgs.neofetch
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # TODO: git settings #
  programs.git.enable = true;
  # #

  # Shells #
  # TODO: remove bash? macOS barks at some of these settings
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

  # zsh
  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
  programs.zsh.initExtra =
    ''
      export BASH_SILENCE_DEPRECATION_WARNING=1
      source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
      setopt PROMPT_SUBST
      autoload -U colors && colors
      export PS1='%~ $(__git_ps1 "(%s) ")%# '
    '';

  # vim & vscode #
  # NOTE: macOS programs.vim.packageConfigurable = pkgs.vim-darwin
  programs.vim.enable = true;
  programs.vim.packageConfigurable = pkgs.vim-darwin;
  programs.vim.settings = {
    background = "light";
    mouse = "a";
    number = true;
  };
  # TODO: add docker and makefile vscode stuff
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
    ];
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
  };
  # #
}
