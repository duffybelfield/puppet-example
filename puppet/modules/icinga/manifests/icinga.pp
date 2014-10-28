#Run on puppetmaster to generate configs
class icinga::icinga {

include icinga::packages

#Directory where defined checks reside
$baseconfigdir="/etc/icinga/modules"

#File containing host definitions
$conf_file_hosts="hosts_pupp_gen.cfg"

#File containing service definitions
$conf_file_srvs="srvs_pupp_gen.cfg"

$conf_file_extra = "extra_pupp_gen.cfg"

Nagios_service <<||>> {
  #Restart Icinga when new services are added.

  target => "${baseconfigdir}/${conf_file_srvs}",
  notify => Service['icinga']
 }

file { "${baseconfigdir}/${conf_file_srvs}":
  ensure => "file",
  owner  => "nagios",
  group  => "nagios",
  mode   => "0644",
  notify => Service['icinga']
}

Nagios_host <<||>> {
  #Restart Icinga when new hosts are added.

  target => "${baseconfigdir}/${conf_file_hosts}",
  notify => Service['icinga']
}

file { "${baseconfigdir}/${conf_file_hosts}":
  ensure   => "file",
  owner    => "nagios",
  group    => "nagios",
  mode     => "0644",
  notify   => Service['icinga']
}

Nagios_hostextinfo <<||>> {
  #Restart Icinga when new services are added.

  target => "${baseconfigdir}/${conf_file_extra}",
  notify => Service['icinga']
 }

file { "${baseconfigdir}/${conf_file_extra}":
  ensure => "file",
  owner  => "nagios",
  group  => "nagios",
  mode   => "0644",
  notify => Service['icinga']
}

service{'icinga':
  ensure     => running,
  hasrestart => true,
  hasstatus  => true,
  restart    => 'service icinga restart'
}

service{'nagios-nrpe-server':
	ensure => running,
	hasrestart => true,
	hasstatus => true,
	restart => 'service nagios-nrpe-server restart'
	}
}
