# Class: profiles::tools::cfssl
#
# Cloudflare CFSSL configuration
# 
class profiles::tools::cfssl (
  Boolean $enabled       = false,
  String  $version       = '1.6.5',
  String  $repo          = 'cloudflare/cfssl',
  Array   $binaries      = ['cfssl', 'cfssljson', 'cfssl-certinfo'],
  String  $binary_suffix = '_1.6.5_linux_amd64',
) {
  # Invocamos el tipo definido del módulo componente con sus datos específicos
  profiles::tools::tool { 'cfssl':
    enabled       => $enabled,
    version       => $version,
    repo          => $repo,
    binaries      => $binaries,
    binary_suffix => $binary_suffix,
  }
}

