class init {
	exec {
		'enable ll alias':
		command => "/bin/echo \"alias ll='ls -lhG'\" >> /home/vagrant/.bashrc"
	}
}

include init
include statsd
include graphite