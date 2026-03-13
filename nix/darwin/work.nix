{ user, ... }: {
    homebrew = {
        casks = [
            "appcleaner"
            "cleanshot"
            "displaylink"
            "drawio"
            "microsoft-auto-update"
            "microsoft-teams"
            "onedrive"
        ];
    };

    users.users.${user.name} = {
        home = user.home;
    };

    system = {
        primaryUser = user.name;
    };
}
