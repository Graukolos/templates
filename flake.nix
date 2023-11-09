{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        {
          default =
            let
              pkgs = import nixpkgs { inherit system; };
            in
            pkgs.mkShell {
              buildInputs = with pkgs; [
                nil
                nixpkgs-fmt
              ];
            };
        }
      );

      templates = {
        default = {
          path = ./default;
          description = "A starting point for development environments";
        };

        bare-metal = {
          path = ./bare-metal;
          description = "A starting point for aarch64 bare-metal development";
        };
      };
    };
}
