{ pkgs, ... }: {
    imports = [ ./common.nix ];

    home.packages = with pkgs; [
        amazon-ecr-credential-helper
        aws-vault
        awscli2
        colima
        docker
        ssm-session-manager-plugin
        uv
    ];
}
