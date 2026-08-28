class profile::unattended_upgrades {
  package { 'unattended-upgrades':
    ensure => 'installed',
  }

  service { 'unattended-upgrades':
    ensure  => 'running',
    enable  => true,
    require => Package['unattended-upgrades'],
  }

  file { '/etc/apt/apt.conf.d/20auto-upgrades':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";\n",
    require => Package['unattended-upgrades'],
  }
}
