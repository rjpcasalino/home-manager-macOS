{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "rjpc";
  home.homeDirectory = "/Users/rjpc";
  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Darwin stuff
  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;

  # see: https://nix.dev/recipes/best-practices
  # avoid "with"
  home.packages = builtins.attrValues {
    inherit (pkgs)
      lolcat
      nixpkgs-fmt
      neofetch;
  };

  home.file = { };
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager. enable = true;

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
      pu = "push";
    };
  };

  programs.jq = {
    enable = true;
    colors = {
      null = "1;30";
      false = "0;31";
      true = "0;32";
      numbers = "0;36";
      strings = "0;33";
      arrays = "1;35";
      objects = "1;37";
    };
  };

  programs.ripgrep.enable = true;

  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    "..." = "cd ../..";
    "dc" = "docker-compose";
    "de" = "docker exec -it";
    "dps" = "docker ps";
    "dnls" = "docker network ls";
    "dnin" = "docker network inspect";
    "ddie" = "docker system prune -a --volumes";
    "nd" = "nix develop";
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
      export PS1='%F{magenta}%n%f %B%F{blue}%~%f $(__git_ps1 "(%s) ")%b%# '
    '';
  # #

  # vim & vscode #
  # NOTE: macOS programs.vim.packageConfigurable = pkgs.vim-darwin
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim-darwin;
    plugins = builtins.attrValues {
      inherit (pkgs.vimPlugins)
        colorizer
        csv-vim
        csv
        lightline-vim
        matchit-zip
        vim-go
        vim-nix
        vim-terraform
        vim-lsp;
    };
    settings = {
      background = "light";
      mouse = "a";
      number = true;
      tabstop = 8;
    };
    extraConfig = ''
      if !has('gui_running')
        set t_Co=256
      endif
      colorscheme default
      syntax on
      set ruler
      set hlsearch
      set spelllang=en_us
      set paste
      set list
      set listchars=eol:¬,tab:▸\ ,trail:·
      set wildmenu
      set wildmode=longest,list,full
      " don't pollute dirs with swap files
      " keep them in one place
      silent !mkdir -p ~/.vim/{backup,swp}/
      set backupdir=~/.vim/backup/
      set directory=~/.vim/swp/
      let g:netrw_preview = 1
      let g:netrw_banner = 1
      let g:netrw_liststyle = 3
      let g:netrw_winsize = 25
      noremap <F11> :tabprevious<CR>
      noremap <F12> :tabnext<CR>
      augroup vimrc
        autocmd!
        au BufRead,BufNewFile *.md,*.txt,*.man,*.ms setlocal spell
        hi clear SpellBad
        hi SpellBad cterm=underline,bold ctermfg=red
      augroup END
      runtime macros/matchit.vim
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
}
