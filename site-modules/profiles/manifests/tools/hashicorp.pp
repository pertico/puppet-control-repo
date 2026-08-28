# Class: profiles::tools::hashicorp
#
# Install hashicorp tools
# 
# @param terraform
# Install terraform
class profiles::tools::hashicorp (
  Boolean $terraform = false
) {
  # Descarga de la clave GPG en /etc/apt/keyrings/hashicorp-archive-keyring.gpg
  apt::keyring { 'hashicorp.asc':
    source => 'https://apt.releases.hashicorp.com/gpg',
  }

  # Configuración del repositorio en formato DEB822 (.sources)
  apt::source { 'hashicorp':
#   source_format => 'sources',
    location      => 'https://apt.releases.hashicorp.com',
    keyring       => '/etc/apt/keyrings/hashicorp.asc',
    release       => $facts['os']['distro']['codename'],
    repos         => 'main',
    architecture  => 'amd64',
    types         => ['deb'],
  }

# Limpieza del archivo .list antiguo para evitar duplicados en APT
#  file { '/etc/apt/sources.list.d/hashicorp.list':
#    ensure => absent,
#    before => Exec['apt_update'],
#  }

  if $terraform {
    package { 'terraform':
      ensure => present
    }
  } else {
    package { 'terraform':
      ensure => absent
    }
  }
}
