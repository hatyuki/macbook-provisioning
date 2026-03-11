{ user, ... }: {
    homebrew = {
        casks = [
            "cleanmymac"
            "docker-desktop"
            "parallels-client"
            "parsec"
            "raspberry-pi-imager"
            "surfshark"
        ];
    };

    users.users.${user.name} = {
        home = user.home;
    };

    system = {
        primaryUser = user.name;
    };
}
