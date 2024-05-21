{...}: {
  programs.firefox = {
    enable = true;
    policies.Extension.Install = [
      "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi"
      "https://addons.mozilla.org/firefox/downloads/latest/norsk-bokmål-ordliste/latest.xpi"
      "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
    ];
  };
}
