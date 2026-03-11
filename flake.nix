{
    description = "provisioning my environment";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixpkgs-unstable";
        };

        nix-darwin = {
            url = "github:nix-darwin/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        nixpkgs,
        nix-darwin,
        home-manager,
        ...
    }: let
        # ヘルパー関数: ユーザー設定を受け取って darwinSystem を構築する
        mkDarwinConfig = { user, darwinModule, homeManagerModule }:
            nix-darwin.lib.darwinSystem {
                specialArgs = { inherit user; };
                modules = [
                    ./nix/darwin/common.nix
                    darwinModule
                    home-manager.darwinModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = { inherit user; };
                        home-manager.users.${user.name} = {
                          imports = [ (import homeManagerModule) ];
                        };
                    }
                ];
            };
    in {
        darwinConfigurations = {
            "Private" = mkDarwinConfig {
                user = rec {
                    name = "hatyuki";
                    home = "/Users/${name}";
                };
                darwinModule = ./nix/darwin/private.nix;
                homeManagerModule = ./nix/home-manager/private.nix;
            };

            "Work" = mkDarwinConfig {
                user = rec {
                    name = "y-user";
                    home = "/Users/${name}";
                };
                darwinModule = ./nix/darwin/work.nix;
                homeManagerModule = ./nix/home-manager/work.nix;
            };
        };
    };
}
