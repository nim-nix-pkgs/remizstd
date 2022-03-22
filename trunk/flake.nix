{
  description = ''Nim bindings for the ZStandard compression library.  Context-based and stream-based APIs available.  Based on the zstd.cr Crystal bindings.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-remizstd-trunk.flake = false;
  inputs.src-remizstd-trunk.ref   = "refs/heads/trunk";
  inputs.src-remizstd-trunk.owner = "RemiliaScarlet";
  inputs.src-remizstd-trunk.repo  = "remizstd";
  inputs.src-remizstd-trunk.type  = "gitlab";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-remizstd-trunk"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-remizstd-trunk";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}