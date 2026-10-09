# k9s-k8smgt-formula

A Saltstack formula designed to install and configure the [K9S](https://k9scli.io/) CLI to manage Kubernetes clusters (and to uninstall the CLI, later).

It is primarily expected that this formula will be run via [P3](https://www.plus3it.com/)'s "[watchmaker](https://watchmaker.readthedocs.io/en/stable/)" framework.

This formula is able to install the K9s CLI utility on both Linux[^1] and Windows Server[^2] operating environments:

**Note:** Pillar-data is _required_ for this formula to function, correctly. This formula does not include any default download URIs. If downloading directly from the internet, the URIs to target are specificed under the GitHub project's [releases](https://github.com/derailed/k9s/releases) page.

## Available states

- [k9s-k8smgt](#k9s-k8smgt)
- [k9s-k8smgt.clean](#k9s-k8smgt.clean)
- [k9s-k8smgt.package](#k9s-k8smgt.package)
- [k9s-k8smgt.package.clean](#k9s-k8smgt.package.clean)
- [k9s-k8smgt.config](#k9s-k8smgt.config)
- [k9s-k8smgt.config.clean](#k9s-k8smgt.config.clean)

### k9s-k8smgt

Executes the `package` and `config` states to install and configure the K9S CLI utility for managing Kubernetes clusters. This includes the utility's binaries and user-configuration template files.

### k9s-k8smgt.clean

Executes the `package` and `config` states' `clean` actions to fully uninstall the K9S CLI utility for managing Kubernetes clusters. This includes uninstalling the binaries and user-configuration template files.

### k9s-k8smgt.package

Executes the `package` state to install the K9S CLI utility for managing Kubernetes clusters. This includes only the utility's binaries.

### k9s-k8smgt.package.clean

Executes the `package` state's `clean` function to uninstall the K9S CLI utility for managing Kubernetes clusters. This includes only the utility's binaries.

### k9s-k8smgt.config

Executes the `config` state to install the K9S CLI utility for managing Kubernetes clusters. This includes only the utility's user-configuration template files.

### k9s-k8smgt.config.clean

Executes the `config` state's `clean` function to uninstall the K9S CLI utility for managing Kubernetes clusters. This includes only the utility's user-configuration template files.

[^1]: As of this README's writing, only Enterprise Linux and related distros (Red Hat and Oracle Enterprise, CentOS Stream, Rocky and Alma Linux) are supported. Further, it has only been specifically tested with EL **_9_** variants.
[^2]: As of this README's writing, this functionality has only been tested on Windows Server 2022
