{ callPackage, python, pygobject3, gtk3, glib, libnotify, intltool, makeWrapper, gobjectIntrospection }:
let pkg = import ./base.nix {
  version = "3.0.0";
  pkgName = "gcdemu";
  pkgSha256 = "1m5ab325r586v2y2d93a817phn6wck67y5mfkf948mph40ks0mqk";
};
in callPackage pkg {
  buildInputs = [ python pygobject3 gtk3 glib libnotify intltool makeWrapper ];
  drvParams = {
    postFixup = ''
      wrapProgram $out/bin/gcdemu \
        --set PYTHONPATH "$PYTHONPATH" \
        --set GI_TYPELIB_PATH "$GI_TYPELIB_PATH" \
        --prefix XDG_DATA_DIRS : "$out/share:$GSETTINGS_SCHEMAS_PATH:$XDG_DATA_DIRS"
    '';
    # TODO AppIndicator
  };
}
