class statsd {
	include nodejs

	package {
		"git": ensure => "present";
		"g++": ensure => "present";
		"npm": ensure => "present";
	}

	package { 'forever':
		ensure   => 'present',
		provider => 'npm',
		require => Package['npm', 'g++'],
	}

	file { "/opt/statsD":
		ensure => "directory",
		owner  => "vagrant",
		group  => "vagrant",
		mode   => 1766
	}

	exec {
		'clone statsD':
		command => "/usr/bin/git clone https://github.com/etsy/statsd.git /opt/statsD",
		creates => "/opt/statsD/README.md",
		require => [Package["git"], File["/opt/statsD"]]
	}

	exec {
		'make sure no forever processes are running':
		command => "/usr/local/bin/forever stopall",
		require => Package['forever']
	}

	exec {
		'start statsD with forever':
		command => "/usr/local/bin/forever start -m 1 /opt/statsD/stats.js /opt/statsD/exampleConfig.js",
		require => [
			Exec['make sure no forever processes are running'],
			Exec['clone statsD'],
			Package['forever']
		]
	}
}
