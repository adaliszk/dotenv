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
        "passff@invicem.pro" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/passff/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    extraPrefs = ''
      defaultPref("browser.startup.page", 3); // Restore Session
      lockPref("browser.startup.homepage", "about:blank");
      lockPref("extensions.activeThemeID", "{78a5c5f7-7289-43c2-b420-3197d7a7557c}");
      defaultPref("sidebar.revamp", true);
      defaultPref("sidebar.verticalTabs", true);
      defaultPref("sidebar.visibility", "expand-on-hover");
      defaultPref("sidebar.main.tools", "bookmarks");
    '';
  };
in
buildEnv {
  name = "browser";
  paths = [
    zenFox
  ];
}
