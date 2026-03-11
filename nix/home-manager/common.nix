{ pkgs, user, ... }: {
    home = {
        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "25.11"; # Please read the comment before changing.

        username = user.name;
        homeDirectory = user.home;

        # 共通パッケージ
        packages = with pkgs; [
            _1password-cli
            coreutils
            devbox
            ghq
            git
            git-lfs
            go
            (
                google-cloud-sdk.withExtraComponents [
                    google-cloud-sdk.components.docker-credential-gcr
                ]
            )
            jq
            lv
            mise
            peco
            sheldon
            yazi
            zellij
        ];
    };
}
