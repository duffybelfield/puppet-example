class icinga::packages{
	package{'nagios-plugins': ensure => installed}
	package{'nagios-plugins-standard': ensure => installed}
	package{'nagios-plugins-extra': ensure => installed}
	package{'nagios-nrpe-server': ensure => installed}
	package{'nagios-nrpe-plugin': ensure => installed}
	package{'libnagios-plugin-perl': ensure => installed}
}
