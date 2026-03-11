{ user, ... }: {
    homebrew = {
        casks = [
            "appcleaner"
            "displaylink"
            "drawio"
            "figma"
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
