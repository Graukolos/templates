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
              ];
            };
        }
      );
    };
}
