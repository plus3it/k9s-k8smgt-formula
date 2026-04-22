chrome:
  lookup:
    installer_uri_win: 'https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe'
    installer_uri_lin: 'https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
k9s-k8smgt:
  lookup:
    {%- if grains.os_family == "RedHat" %} 	# Configure for ELx Linux distros
    pkg:
      name: 'https://github.com/derailed/k9s/releases/download/v0.50.18/k9s_linux_amd64.rpm'
    {%- elif grains.os_family == "Windows" %}	# COnfigure for Windows-based hosts
    pkg:
      name: 'https://github.com/derailed/k9s/releases/download/v0.50.18/k9s_Windows_amd64.zip'
    {%- endif %}
    config:
      skins:
        catppuccin-mocha: https://raw.githubusercontent.com/catppuccin/k9s/main/dist/catppuccin-mocha.yaml
        dracula: https://raw.githubusercontent.com/derailed/k9s/master/skins/dracula.yaml
        nord: https://raw.githubusercontent.com/derailed/k9s/master/skins/nord.yaml
        tokyonight: https://raw.githubusercontent.com/axkirillov/k9s-tokyonight/main/skin.yml
        gruvbox-dark: https://raw.githubusercontent.com/derailed/k9s/master/skins/gruvbox-dark.yaml
        one-dark: https://raw.githubusercontent.com/derailed/k9s/master/skins/one-dark.yaml
        solarized-dark: https://raw.githubusercontent.com/derailed/k9s/master/skins/solarized-dark.yaml
        monokai: https://raw.githubusercontent.com/derailed/k9s/master/skins/monokai.yaml
        rose-pine: https://raw.githubusercontent.com/sasoria/k9s-theme/main/rose-pine.yaml
