class profile::puppet_agent (
  String $server = 'puppet',
  String $runinterval = '6h',
  Boolean $include_package_inventory = false
) {

  ini_setting { 'server':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'server',
    value   => $server,
    notify  => Service['puppet'],
  }

  ini_setting { 'runinterval':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'runinterval',
    value   => $runinterval,
    notify  => Service['puppet'],
  }

  ini_setting { 'include_package_inventory':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'include_package_inventory',
    value   => 'true',
    notify  => Service['puppet'],
  }

  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

}
