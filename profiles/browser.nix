{ pkgs, ... }:
with pkgs;

let
  zenFox = wrapFirefox firefox-esr-unwrapped {
    nixExtensions = [
      (fetchFirefoxAddon {
        name = "ublock-origin";
        url = "https://github.com/gorhill/uBlock/releases/download/1.71.0/uBlock0_1.71.0.firefox.signed.xpi";
        sha256 = lib.fakeSha256;
      })
      (fetchFirefoxAddon {
        name = "dark-reader";
        url = "https://github.com/darkreader/darkreader/releases/download/v4.9.127/darkreader-firefox.xpi";
        sha256 = lib.fakeSha256;
      })
      (fetchFirefoxAddon {
        name = "matte-theme";
        url = "https://addons.mozilla.org/firefox/downloads/latest/matte-black-spring-green/latest.xpi";
        sha256 = lib.fakeSha256;
      })
    ];
    extraPolicies = {
      DisableTelemetry = true;
    };
    extraPrefs = ''
      lockPref("browser.startup.homepage", "about:blank");
    '';
  };
in
buildEnv {
  name = "browser";
  paths = [
    zenFox
  ];
}
