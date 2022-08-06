# Building a flake-based configuration is as simple as
#
#     home-manager switch --flake '<flake-uri>#jdoe'
#
# Here, jdoe is a configuration specified in the flake file, and <flake-uri>#jdoe will be
# expanded to <flake-uri>#homeConfigurations.jdoe.activationPackage and be built by Nix.
#
# Note:
#
# - The flake inputs are not upgraded automatically when switching. The analogy to the command
#   home-manager --update ... is nix flake update.
#
# - If updating more than one input is undesirable, the command
#   nix flake lock --update-input <input-name> can be used.
#
# - You can also pass flake-related options such as --recreate-lock-file or --update-input [input]
#   to home-manager when building/switching, and these options will be forwarded to nix build.

{ config, pkgs, nixGL, ... }:

let

  nGL = import nixGL { inherit pkgs; };

  withNixGL = package: name: pkgs.writeShellScriptBin name ''
    ${nGL.nixGLIntel}/bin/nixGLIntel ${package}/bin/${name} "$@"
  '';

in {
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jgutierrez";
  home.homeDirectory = "/home/jgutierrez";

  home.packages = with pkgs; [
    fzf
    ripgrep
    htop
    less
    gnupg
    xclip
    xsel
    curl
    bind
    whois
    neovim

    # TODO Probably add some of these to bitnomial-tools.nix
    vagrant
    haskellPackages.hoogle
    # haskellPackages.ghcup # TODO This is marked as broken, maybe fix it
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "22.05"; # This is specified in the flake.nix instead

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git.enable = true;
  programs.git.userName = "Julio César";
  programs.git.userEmail = "julio.gutierrez@bitnomial.com";
  programs.git.signing = {
    key = "67CAED28B2A90C16";
   signByDefault = true;
  };
  programs.git.aliases = {
    logs = "log --show-signature";
    graphs = "log --all --graph --decorate --oneline";
  };

  programs.git.extraConfig = {
    core.pager = "less -XFRS";
    core.editor = "nvim";
    init.defaultBranch = "master";
    pull.rebase = true;
    pull.ff = "only";
    fetch.prune = true;
    color.ui = true;
    color.pager = true;
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };

  # TODO Move out of here
  programs.alacritty = {
    enable = true;

    package = withNixGL pkgs.alacritty "alacritty";

    settings = {
      # env = {
      #   TERM = "xterm-256color";
      # };
      shell = {
        program = "/usr/bin/zsh";
        args = [ "-l" "-c" "/home/jgutierrez/.nix-profile/bin/tmux -q has-session && exec /home/jgutierrez/.nix-profile/bin/tmux attach-session -d || exec /home/jgutierrez/.nix-profile/bin/tmux -u new-session -n$HOST" ];
      };

      window = {
        opacity = 1.0;
        dimensions.columns = 80;
        dimensions.lines = 24;
        padding.x = 0;
        padding.y = 0;

        decorations = "none";
        startup_mode = "Fullscreen";
      };

      font = {
        size = 13.0;
        offset.x = 0;
        offset.y = 6;
      };

      draw_bold_text_with_bright_colors = true;

      colors = {
        primary = {
          background = "#101421";
          foreground = "#fffbf6";
        };

        # Normal colors
        normal = {
          black =   "#2e2e2e";
          red =     "#eb4129";
          green =   "#abe047";
          yellow =  "#f6c744";
          blue =    "#47a0f3";
          magenta = "#7b5cb0";
          cyan =    "#64dbed";
          white =   "#e5e9f0";
        };

        # Bright colors
        bright = {
          black =   "#565656";
          red =     "#ec5357";
          green =   "#c0e17d";
          yellow =  "#f9da6a";
          blue =    "#49a4f8";
          magenta = "#a47de9";
          cyan =    "#99faf2";
          white =   "#ffffff";
        };
      };

      mouse_bindings = [
        { mouse = "Right"; action = "PasteSelection"; }
      ];

      selection.save_to_clipboard = true;

      cursor.style = "Block";

      key_bindings = [
        { key = "V";         mods = "Control|Shift"; action = "Paste";            }
        { key = "C";         mods = "Control|Shift"; action = "Copy";             }
        { key = "Insert";    mods = "Shift";         action = "PasteSelection";   }
        { key = "Key0";      mods = "Control";       action = "ResetFontSize";    }
        { key = "Equals";    mods = "Control";       action = "IncreaseFontSize"; }
        { key = "Plus";      mods = "Control";       action = "IncreaseFontSize"; }
        { key = "Minus";     mods = "Control";       action = "DecreaseFontSize"; }
        { key = "Minus";     mods = "Control";       action = "DecreaseFontSize"; }
        { key = "N";         mods = "Super|Shift";   action = "SpawnNewInstance"; }
        { key = "F";         mods = "Super|Shift";   action = "ToggleFullscreen"; }
        { key = "Space";     mods = "Control";       action = "ToggleViMode";     }


        # Vi Mode
        { key = "J";         mode = "Vi";            action = "Left";             }
        { key = "K";         mode = "Vi";            action = "Down";             }
        { key = "H";         mode = "Vi";            action = "Up";               }
        { key = "Q";         mode = "Vi";            action = "ToggleViMode";     }


        { key = "Paste";                      action = "Paste";                                }
        { key = "Copy";                       action = "Copy";                                 }
        { key = "L";        mods = "Control"; action = "ClearLogNotice";                       }
        { key = "L";        mods = "Control"; chars = "\\x0c";                                 }
        { key = "Home";     mods = "Alt";     chars = "\\x1b[1;3H";                            }
        { key = "Home";                       chars = "\\x1bOH";          mode = "AppCursor";  }
        { key = "Home";                       chars = "\\x1b[H";          mode = "~AppCursor"; }
        { key = "End";      mods = "Alt";     chars = "\\x1b[1;3F";                            }
        { key = "End";                        chars = "\\x1bOF";          mode = "AppCursor";  }
        { key = "End";                        chars = "\\x1b[F";          mode = "~AppCursor"; }
        { key = "PageUp";   mods = "Shift";   action = "ScrollPageUp";   mode = "~Alt";        }
        { key = "PageUp";   mods = "Shift";   chars = "\\x1b[5;2~";       mode = "Alt";        }
        { key = "PageUp";   mods = "Control"; chars = "\\x1b[5;5~";                            }
        { key = "PageUp";   mods = "Alt";     chars = "\\x1b[5;3~";                            }
        { key = "PageUp";                     chars = "\\x1b[5~";                              }
        { key = "PageDown"; mods = "Shift";   action = "ScrollPageDown"; mode = "~Alt";        }
        { key = "PageDown"; mods = "Shift";   chars = "\\x1b[6;2~";       mode = "Alt";        }
        { key = "PageDown"; mods = "Control"; chars = "\\x1b[6;5~";                            }
        { key = "PageDown"; mods = "Alt";     chars = "\\x1b[6;3~";                            }
        { key = "PageDown";                   chars = "\\x1b[6~";                              }
        { key = "Tab";      mods = "Shift";   chars = "\\x1b[Z";                               }
        { key = "Back";                       chars = "\\x7f";                                 }
        { key = "Back";     mods = "Alt";     chars = "\\x1b\\x7f";                            }
        { key = "Insert";                     chars = "\\x1b[2~";                              }
        { key = "Delete";                     chars = "\\x1b[3~";                              }
        { key = "Left";     mods = "Shift";   chars = "\\x1b[1;2D";                            }
        { key = "Left";     mods = "Control"; chars = "\\x1b[1;5D";                            }
        { key = "Left";     mods = "Alt";     chars = "\\x1b[1;3D";                            }
        { key = "Left";                       chars = "\\x1b[D";          mode = "~AppCursor"; }
        { key = "Left";                       chars = "\\x1bOD";          mode = "AppCursor";  }
        { key = "Right";    mods = "Shift";   chars = "\\x1b[1;2C";                            }
        { key = "Right";    mods = "Control"; chars = "\\x1b[1;5C";                            }
        { key = "Right";    mods = "Alt";     chars = "\\x1b[1;3C";                            }
        { key = "Right";                      chars = "\\x1b[C";          mode = "~AppCursor"; }
        { key = "Right";                      chars = "\\x1bOC";          mode = "AppCursor";  }
        { key = "Up";       mods = "Shift";   chars = "\\x1b[1;2A";                            }
        { key = "Up";       mods = "Control"; chars = "\\x1b[1;5A";                            }
        { key = "Up";       mods = "Alt";     chars = "\\x1b[1;3A";                            }
        { key = "Up";                         chars = "\\x1b[A";          mode = "~AppCursor"; }
        { key = "Up";                         chars = "\\x1bOA";          mode = "AppCursor";  }
        { key = "Down";     mods = "Shift";   chars = "\\x1b[1;2B";                            }
        { key = "Down";     mods = "Control"; chars = "\\x1b[1;5B";                            }
        { key = "Down";     mods = "Alt";     chars = "\\x1b[1;3B";                            }
        { key = "Down";                       chars = "\\x1b[B";          mode = "~AppCursor"; }
        { key = "Down";                       chars = "\\x1bOB";          mode = "AppCursor";  }
        { key = "F1";                         chars = "\\x1bOP";          }
        { key = "F2";                         chars = "\\x1bOQ";          }
        { key = "F3";                         chars = "\\x1bOR";          }
        { key = "F4";                         chars = "\\x1bOS";          }
        { key = "F5";                         chars = "\\x1b[15~";        }
        { key = "F6";                         chars = "\\x1b[17~";        }
        { key = "F7";                         chars = "\\x1b[18~";        }
        { key = "F8";                         chars = "\\x1b[19~";        }
        { key = "F9";                         chars = "\\x1b[20~";        }
        { key = "F10";                        chars = "\\x1b[21~";        }
        { key = "F11";                        chars = "\\x1b[23~";        }
        { key = "F12";                        chars = "\\x1b[24~";        }
        { key = "F1";       mods = "Shift";   chars = "\\x1b[1;2P";       }
        { key = "F2";       mods = "Shift";   chars = "\\x1b[1;2Q";       }
        { key = "F3";       mods = "Shift";   chars = "\\x1b[1;2R";       }
        { key = "F4";       mods = "Shift";   chars = "\\x1b[1;2S";       }
        { key = "F5";       mods = "Shift";   chars = "\\x1b[15;2~";      }
        { key = "F6";       mods = "Shift";   chars = "\\x1b[17;2~";      }
        { key = "F7";       mods = "Shift";   chars = "\\x1b[18;2~";      }
        { key = "F8";       mods = "Shift";   chars = "\\x1b[19;2~";      }
        { key = "F9";       mods = "Shift";   chars = "\\x1b[20;2~";      }
        { key = "F10";      mods = "Shift";   chars = "\\x1b[21;2~";      }
        { key = "F11";      mods = "Shift";   chars = "\\x1b[23;2~";      }
        { key = "F12";      mods = "Shift";   chars = "\\x1b[24;2~";      }
        { key = "F1";       mods = "Control"; chars = "\\x1b[1;5P";       }
        { key = "F2";       mods = "Control"; chars = "\\x1b[1;5Q";       }
        { key = "F3";       mods = "Control"; chars = "\\x1b[1;5R";       }
        { key = "F4";       mods = "Control"; chars = "\\x1b[1;5S";       }
        { key = "F5";       mods = "Control"; chars = "\\x1b[15;5~";      }
        { key = "F6";       mods = "Control"; chars = "\\x1b[17;5~";      }
        { key = "F7";       mods = "Control"; chars = "\\x1b[18;5~";      }
        { key = "F8";       mods = "Control"; chars = "\\x1b[19;5~";      }
        { key = "F9";       mods = "Control"; chars = "\\x1b[20;5~";      }
        { key = "F10";      mods = "Control"; chars = "\\x1b[21;5~";      }
        { key = "F11";      mods = "Control"; chars = "\\x1b[23;5~";      }
        { key = "F12";      mods = "Control"; chars = "\\x1b[24;5~";      }
        { key = "F1";       mods = "Alt";     chars = "\\x1b[1;6P";       }
        { key = "F2";       mods = "Alt";     chars = "\\x1b[1;6Q";       }
        { key = "F3";       mods = "Alt";     chars = "\\x1b[1;6R";       }
        { key = "F4";       mods = "Alt";     chars = "\\x1b[1;6S";       }
        { key = "F5";       mods = "Alt";     chars = "\\x1b[15;6~";      }
        { key = "F6";       mods = "Alt";     chars = "\\x1b[17;6~";      }
        { key = "F7";       mods = "Alt";     chars = "\\x1b[18;6~";      }
        { key = "F8";       mods = "Alt";     chars = "\\x1b[19;6~";      }
        { key = "F9";       mods = "Alt";     chars = "\\x1b[20;6~";      }
        { key = "F10";      mods = "Alt";     chars = "\\x1b[21;6~";      }
        { key = "F11";      mods = "Alt";     chars = "\\x1b[23;6~";      }
        { key = "F12";      mods = "Alt";     chars = "\\x1b[24;6~";      }
        { key = "F1";       mods = "Super";   chars = "\\x1b[1;3P";       }
        { key = "F2";       mods = "Super";   chars = "\\x1b[1;3Q";       }
        { key = "F3";       mods = "Super";   chars = "\\x1b[1;3R";       }
        { key = "F4";       mods = "Super";   chars = "\\x1b[1;3S";       }
        { key = "F5";       mods = "Super";   chars = "\\x1b[15;3~";      }
        { key = "F6";       mods = "Super";   chars = "\\x1b[17;3~";      }
        { key = "F7";       mods = "Super";   chars = "\\x1b[18;3~";      }
        { key = "F8";       mods = "Super";   chars = "\\x1b[19;3~";      }
        { key = "F9";       mods = "Super";   chars = "\\x1b[20;3~";      }
        { key = "F10";      mods = "Super";   chars = "\\x1b[21;3~";      }
        { key = "F11";      mods = "Super";   chars = "\\x1b[23;3~";      }
        { key = "F12";      mods = "Super";   chars = "\\x1b[24;3~";      }
        { key = "NumpadEnter";                chars = "\n";               }
      ];
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 0;
    clock24 = false;
    escapeTime = 10;
    historyLimit = 10000;
    keyMode = "vi";
    newSession = true;
    prefix = "C-t";
    secureSocket = true;
    terminal = "tmux-256color";

    aggressiveResize = true;

    # tmuxPlugins = [];

    # TODO Read from file
    extraConfig = ''
      setw -g clock-mode-style

      # To enable truecolors in Vim
      set -sa terminal-overrides ',xterm-256color:RGB'

      # Window navigation
      bind C-t last-window
      bind t last-window
      bind c new-window -c "#{pane_current_path}"

      # Window splits
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # More vi-like visual selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi C-k send-keys -X scroll-down
      bind-key -T copy-mode-vi C-h send-keys -X scroll-up
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi C-[ send-keys -X cancel

      # Colemak movement
      bind-key h send-keys -X cursor-up
      bind-key k send-keys -X cursor-down
      bind-key j send-keys -X cursor-left
      bind-key -T copy-mode-vi k send-keys -X cursor-down
      bind-key -T copy-mode-vi h send-keys -X cursor-up
      bind-key -T copy-mode-vi j send-keys -X cursor-left

      bind-key -r h select-pane -U
      bind-key -r k select-pane -D
      bind-key -r j select-pane -L
      bind-key -r l select-pane -R

      bind -r J resize-pane -L 5
      bind -r K resize-pane -D 5
      bind -r H resize-pane -U 5
      bind -r L resize-pane -R 5

      ######################## THEME CUSTOMIZATION ########################

      # NOTE: you can use vars with $<var> and ''${<var>} as long as the str is double quoted: ""
      # WARNING: hex colors can't contain capital letters

      # --> Catppuccin
      thm_bg="#1e1e28"
      thm_fg="#dadae8"
      thm_cyan="#c2e7f0"
      thm_black="#15121c"
      thm_gray="#332e41"
      thm_magenta="#c6aae8"
      thm_pink="#e5b4e2"
      thm_red="#e38c8f"
      thm_green="#b1e3ad"
      thm_yellow="#ebddaa"
      thm_blue="#a4b9ef"
      thm_orange="#f9c096"
      thm_black4="#575268"

      # ----------------------------=== Theme ===--------------------------

      # status
      set -g status-position bottom
      set -g status "on"
      set -g status-bg "''${thm_bg}"
      set -g status-justify "left"
      set -g status-left-length "100"
      set -g status-right-length "100"

      # messages
      set -g message-style fg="''${thm_cyan}",bg="''${thm_gray}",align="centre"
      set -g message-command-style fg="''${thm_cyan}",bg="''${thm_gray}",align="centre"

      # panes
      set -g pane-border-style fg="''${thm_gray}"
      set -g pane-active-border-style fg="''${thm_blue}"

      # windows
      setw -g window-status-activity-style fg="''${thm_fg}",bg="''${thm_bg}",none
      setw -g window-status-separator ""
      setw -g window-status-style fg="''${thm_fg}",bg="''${thm_bg}",none


      # --------=== Statusline

      set -g status-left ""

      set -g status-right "#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #W %H:%M #{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray] #S "


      setw -g window-status-format "#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{?window_name,#{b:window_name},#{b:pane_current_command}} "
      setw -g window-status-current-format "#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{?window_name,#{b:window_name},#{b:pane_current_command}} "


      # --------=== Modes
      setw -g clock-mode-colour "''${thm_blue}"
      setw -g mode-style "fg=''${thm_pink} bg=''${thm_black4} bold"
    '';
  };
}
