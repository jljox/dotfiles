{
  allowUnfree = true;
  guiSupport = true;

  packageOverrides = super: let self = super.pkgs; in
  {
     my_hs = self.haskellPackages.ghcWithHoogle
        (haskellPackages: with haskellPackages; [
           # libraries
           mtl QuickCheck random text alex hscolour cpphs happy ghc-paths
           # tools
           cabal-install haskintex
        ]);
  };
}
