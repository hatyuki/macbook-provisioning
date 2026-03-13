{ pkgs, ... }: {
    # List of fonts to install into /Library/Fonts/Nix Fonts.
    fonts.packages = with pkgs; [
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-monochrome-emoji
    ];

    homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        caskArgs = {
          appdir = "/Applications";
          require_sha = true;
        };

        taps = [];

        casks = [
            "1password"
            "ghostty"
            "google-chrome"
            "google-japanese-ime"
            "jetbrains-toolbox"
            "raycast"
            "slack"
            "the-unarchiver"
        ];
    };

    # Necessary for using flakes on this system.
    nix = {
        # 自動掃除の設定
        gc = {
            automatic = true;
            interval = { Weekday = 0; Hour = 3; Minute = 0; };
            options = "--delete-older-than 3d";
        };

        optimise.automatic = true; # ストレージの最適化

        # Flakes を使うための設定 (`nix run` 時の `--extra-experimental-features` を不要に)
        settings.experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
    };

    programs = {
        direnv = {
            enable = true;
            nix-direnv.enable = true;
        };
    };

    security = {
        pam = {
            # ターミナルでも TouchID を使えるように
            services.sudo_local = {
                enable      = true;
                reattach    = true;
                touchIdAuth = true;
            };
        };
    };

    system = {
        stateVersion = 6;

        defaults = {
            controlcenter = {
                BatteryShowPercentage = true;  # Menu bar にバッテリー残量 (%) を表示する
                Bluetooth = true;              # Menu bar に Bluetooth コントロールを表示する
            };

            # Dock を自動的に非表示にする
            dock.autohide = true;

            finder = {
                AppleShowAllExtensions = true;    # 全ての拡張子を表示
                FXPreferredViewStyle   = "Nlsv";  # リストビューをデフォルトにする
                ShowPathbar            = true;    # パスバーを表示
                ShowStatusBar          = true;    # ステータスバーを表示
            };

            NSGlobalDomain = {
                # キーリピートの設定を好みにする
                InitialKeyRepeat = 25;
                KeyRepeat = 2;

                "com.apple.keyboard.fnState"  = true;  # F1 / F2 などのキーを標準のファンクションキーとして使用する
                "com.apple.mouse.tapBehavior" = 1;     # Tap to Click を有効化する
                "com.apple.trackpad.scaling"  = 3.0;   # Trackpad の追跡速度を最大値にする (0.0 〜 3.0)
            };

            trackpad = {
                ActuationStrength        = 0;     # Quiet Click を有効化する
                Clicking                 = true;  # Tap to Click を有効化する
                TrackpadThreeFingerDrag = true;  # 三指ドラッグを有効化する
            };
        };
    };
}
