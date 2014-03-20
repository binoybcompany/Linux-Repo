class puppet {
  file { '/usr/bin/papply':
  source => 'puppet:///modules/puppet/papply.sh',
  mode   => '0755',
  }
  file { '/usr/bin/pull-updates':
  source => 'puppet:///modules/puppet/pull-updates.sh',
  mode   => '0755',
  }	
  file { '/root/.ssh/id_rsa':
  source => 'puppet:///modules/puppet/puppetmaster.priv',
  owner  => 'root',
  mode   => '0600',
  }	
  cron { 'run-puppet':
  ensure  => 'present',
  user    => 'root',
  command => '/usr/bin/pull-updates',
  minute  => '*/10',
  hour    => '*',
  }
}	
	
