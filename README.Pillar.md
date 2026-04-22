The `pillar.example` file in the project-root is intended to illustrate how to use SaltStack's [Pillar](https://docs.saltproject.io/en/latest/topics/tutorials/pillar.html) funcitonality to customize the installation and configuration performed by this formula.


```yaml
k9s-k8smgt:					# Top level pillar-key
  lookup:
    pkg:					# Package-related information
      name: ''					# Download URI
  config:					# Configuration-related information
    initial_users: Null				# List of alread-existing users to configure
    skins:					# Skin names and URIs to download from
      <NAME_1>: <URI_1>				#   Entries take the form of:
      <NAME_2>: <URI_2>				#   <SKIN_NAME>: <DOWNLOAD_URI>
      ...:      ...
      <NAME_N>: <URI_N>
```

If deploying in a multi-platform environment, it's recommended to create a pillar-definition like:

```yaml
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
        nightfox: https://raw.githubusercontent.com/derailed/k9s/master/skins/nightfox.yaml
```

The `{%- if grains.os_family ...` content instructs Saltstack to set the encapsulated parameters based on the host operating system's "family". This formula currenlty supports Windows operating systems and Linux operating systems based on Red Hat Enterprise Linux and clones.

* `pkg.name`: If a `pkg.name` is not defined in Pillar, this formula will fail. The project's defaults do not include download paths for either Windows or Linux installations.
* `config.skins`: This pillar parameter is wholly optional. If not specified via Pillar, the automation will attempt to install the K9s skins:
    * `dracula`: One of the "standard" skins released through the K9S project[^1]. Downloads from `https://raw.githubusercontent.com/derailed/k9s/master/skins/dracula.yaml`
    * `nord`: One of the "standard" skins released through the K9S project[^1]. Downloads from `https://raw.githubusercontent.com/derailed/k9s/master/skins/nord.yaml`
    * `gruvbox-dark`: One of the "standard" skins released through the K9S project[^1]. Downloads from `https://raw.githubusercontent.com/derailed/k9s/master/skins/gruvbox-dark.yaml`
    * [`catppuccin-mocha`](https://github.com/catppuccin/k9s): Downloads from `https://raw.githubusercontent.com/catppuccin/k9s/main/dist/catppuccin-mocha.yaml`
    * [`tokyonight`](https://github.com/axkirillov/k9s-tokyonight): Downloads from `https://raw.githubusercontent.com/axkirillov/k9s-tokyonight/main/skin.yml`

    These skins were selected for inclusion as a result of searching for "top 5 skins for K9s". Override if:
    * The deployment environment cannot reach internet-hosted resources
    * The deployment environment's policies prefer use of self-hosted resources
    * A different collection of skins is desired by the site's K9S user-community[^2]

[^1]: GitHub-hosted contents are found at https://github.com/derailed/k9s
[^2]: Pillar content wholly replaces the defaults. If the desired results are to have the default skins supplemented by futher skins, it will be necessary to specify _all_ desired skins in the Pillar contents
