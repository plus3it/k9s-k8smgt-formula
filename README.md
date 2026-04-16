# k9s-k8smgt-formula

A Saltstack formula designed to install and configure the [K9S](https://k9scli.io/) CLI to manage Kubernetes clusters (and to uninstall the CLI, later).

It is primarily expected that this formula will be run via [P3](https://www.plus3it.com/)'s "[watchmaker](https://watchmaker.readthedocs.io/en/stable/)" framework.

This formula is able to install the K9s CLI utility on both Linux[^1] and Windows Server[^2] operating environments:

[^1]: As of this README's writing, only Enterprise Linux and related distros (Red Hat and Oracle Enterprise, CentOS Stream, Rocky and Alma Linux). It has only been specifically tested with EL **_9_** variants.
[^2]: As of this README's writing, this functionality has only been tested on Windows Server 2022


## Available states

- [k9s-k8smgt](#k9s-k8smgt)
- [k9s-k8smgt.clean](#k9s-k8smgt.clean)
- [k9s-k8smgt.package](#k9s-k8smgt.package)
- [k9s-k8smgt.package.clean](#k9s-k8smgt.package.clean)
- [k9s-k8smgt.config](#k9s-k8smgt.config)
- [k9s-k8smgt.config.clean](#k9s-k8smgt.config.clean)
`
