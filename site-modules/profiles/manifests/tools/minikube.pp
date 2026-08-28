# Class: profiles::tools::minikube
#
# minikube configuration
#
class profiles::tools::minikube (
  Boolean $enabled       = false,
  String  $version       = 'latest',
  String  $repo          = 'kubernetes/minikube',
  Array   $binaries      = ['minikube'],
  String  $binary_suffix = '-linux-amd64',
) {

  tools::tool { 'minikube':
    enabled       => $enabled,
    version       => $version,
    repo          => $repo,
    binaries      => $binaries,
    binary_suffix => $binary_suffix,
  }

  # Lógica específica extra: Generar autocompletado de bash si está habilitado
  if $enabled {
    exec { 'minikube_completion':
      command => '/usr/local/bin/minikube completion bash > /etc/bash_completion.d/minikube',
      creates => '/etc/bash_completion.d/minikube',
      require => Tools::Tool['minikube'],
    }
  }
}
