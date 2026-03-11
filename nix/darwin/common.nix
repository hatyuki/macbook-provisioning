{ pkgs, ... }: {
    # List of fonts to install into /Library/Fonts/Nix Fonts.
    fonts.packages = with pkgs; [
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-monochrome-emoji
    ];

    homebrew = {
        enable = true;
        onActivation.cleanup = "none";
        caskArgs = {
          appdir = "~/Applications";
          require_sha = true;
        };

        taps = [];

        casks = [
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

        # ストレージの最適化
        optimise.automatic = true;

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
            services.sudo_local = {
                enable = true;
                reattach = true;
                touchIdAuth = true;
            };
        };
    };

    system = {
        stateVersion = 6;

        defaults = {
            controlcenter = {
                # Menu bar にバッテリー残量 (%) を表示する
                BatteryShowPercentage = true;

                # Menu bar に Bluetooth コントロールを表示する
                Bluetooth = true;
            };

            # Dock を自動的に非表示にする
            dock.autohide = true;

            NSGlobalDomain = {
                # F1 / F2 などのキーを標準のファンクションキーとして使用する
                "com.apple.keyboard.fnState" = true;

                # Trackpad の追跡速度 (0.0 〜 3.0)
                "com.apple.trackpad.scaling" = 3.0;
            };
        };
    };
}
