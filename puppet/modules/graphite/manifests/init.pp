class graphite {
	package {
		"python": ensure => "present";
		"python-pip": ensure => "present";
		"python-cairo": ensure => "present";
		"python-django": ensure => "present", require => Exec['apt-get update'];
		"python-django-tagging": ensure => "present", require => Exec['apt-get update'];
		"python-twisted": ensure => "present";
	}

	exec {
		'apt-get update':
		command => "/usr/bin/apt-get update"
	}

	exec {
		'install whisper':
		command => "/usr/bin/pip install whisper",
		require => [
			Package["python"],
			Package["python-pip"],
			Package["python-cairo"],
			Package["python-django"],
			Package["python-django-tagging"],
			Package["python-twisted"]
		]
	}

	exec {
		'install carbon':
		command => "/usr/bin/pip install carbon",
		require => Exec["install whisper"]
	}

	exec {
		'install graphite-web':
		command => "/usr/bin/pip install graphite-web",
		require => Exec["install whisper"]
	}
}
