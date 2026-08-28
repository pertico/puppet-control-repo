# site-modules/profiles/tools/manifests/tool.pp
define profiles::tools::tool (
  Boolean $enabled       = false,
  String  $version       = 'latest',
  String  $repo          = undef,
  Array   $binaries      = [],
  String  $binary_suffix = '',
) {
  $system_arch = $facts['os']['architecture'] ? {
    'x86_64' => 'amd64',
    default  => 'arm64',
  }

  if !defined(File['/etc/puppetlabs/facter']) {
    file { '/etc/puppetlabs/facter': ensure => directory, mode => '0755' }
  }
  if !defined(File['/etc/puppetlabs/facter/facts.d']) {
    file { '/etc/puppetlabs/facter/facts.d': ensure => directory, mode => '0755', require => File['/etc/puppetlabs/facter'] }
  }

  $current_version = $facts["tools_${title}_version"]

  if $enabled {
    # =========================================================================
    # FLUJO: INSTALACIÓN / ACTUALIZACIÓN
    # =========================================================================
    if $version == 'latest' {
      $url_prefix = "https://github.com/${repo}/releases/latest/download"
    } else {
      $clean_version = regsubst($version, '^v?', 'v')
      $url_prefix    = "https://github.com/${repo}/releases/download/${clean_version}"
    }

    $binaries.each |String $binary| {
      $download_url = "${url_prefix}/${binary}${binary_suffix}"
      $target_path  = "/usr/local/bin/${binary}"

      archive { $target_path:
        ensure  => present,
        source  => $download_url,
        creates => $target_path,
        user    => 'root',
        group   => 'root',
        notify  => File[$target_path],
      }

      file { $target_path:
        ensure  => file,
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        require => Archive[$target_path],
      }
    }

    $archive_requirements = $binaries.map |$b| { "Archive[/usr/local/bin/${b}]" }

    file { "/etc/puppetlabs/facter/facts.d/tools_${title}_version.txt":
      ensure  => file,
      content => "tools_${title}_version=${version}\n",
      mode    => '0644',
      require => [ File['/etc/puppetlabs/facter/facts.d'], $archive_requirements ],
    }

  } else {
    # =========================================================================
    # FLUJO: DESINSTALACIÓN COMPLETA (Si enabled es false)
    # =========================================================================

    # 1. Iteramos sobre cada binario para asegurar su eliminación
    $binaries.each |String $binary| {
      file { "/usr/local/bin/${binary}":
        ensure => absent,
      }

      # Opcional: También eliminamos el registro del módulo archive para limpiar el catálogo
      archive { "/usr/local/bin/${binary}":
        ensure => absent,
      }
    }

    # 2. Eliminamos el archivo del fact persistido para que Facter quede limpio
    file { "/etc/puppetlabs/facter/facts.d/tools_${title}_version.txt":
      ensure  => absent,
      require => File['/etc/puppetlabs/facter/facts.d'],
    }
  }
}
