# Class: profiles::tools::kind
#
# Kubernetes KIND configuration
#
class profiles::tools::kind (
  Boolean $enabled       = false,
  String  $version       = 'latest',
  String  $repo          = 'kubernetes-sigs/kind',
  Array   $binaries      = ['kind'],
  String  $binary_suffix = '-linux-amd64',
) {
  tools::tool { 'kind':
    enabled       => $enabled,
    version       => $version,
    repo          => $repo,
    binaries      => $binaries,
    binary_suffix => $binary_suffix,
  }
}
