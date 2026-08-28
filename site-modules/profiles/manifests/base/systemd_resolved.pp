# Class: profiles::base::systemd_resolved
#
# Install the necessary packages for the host
# 

class profiles::base::systemd_resolved (
  Variant[String, Array[String]] $dns     = ['8.8.8.8'],
  Variant[String, Array[String]] $domains = ['home.arpa'],
) {
  $dns_string     = [$dns].join(' ')
  $domains_string = [$domains].join(' ')

  package { 'systemd-resolved':
    ensure => installed
  }

  service { 'systemd-resolved':
    ensure => 'running',
    enable => true,
  }

  ini_setting { 'DNS':
    ensure            => present,
    section           => 'Resolve',
    path              => '/etc/systemd/resolved.conf',
    setting           => 'DNS',
    key_val_separator => '=',
    value             => $dns_string,
    notify            => Service['systemd-resolved'],
  }

  ini_setting { 'Domains':
    ensure            => present,
    section           => 'Resolve',
    path              => '/etc/systemd/resolved.conf',
    setting           => 'Domains',
    key_val_separator => '=',
    value             => $domains_string,
    notify            => Service['systemd-resolved'],
  }
}
