{ pkgs, ... }:
with pkgs;

let
  zenFox = wrapFirefox firefox-esr-unwrapped {
    extraPolicies = {
      DisableTelemetry = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "{78a5c5f7-7289-43c2-b420-3197d7a7557c}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/matte-black-spring-green/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    extraPrefs = ''
      lockPref("browser.startup.homepage", "about:blank");
      lockPref("extensions.activeThemeID", "{78a5c5f7-7289-43c2-b420-3197d7a7557c}");
    '';
  };
in
buildEnv {
  name = "browser";
  paths = [
    zenFox
  ];
}
