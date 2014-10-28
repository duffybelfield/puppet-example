class icinga::nrpe {
 
  file { "/etc/nagios/nrpe.cfg":
    owner  => 0, group  => 0, mode => 0644,
    content => template("${module_name}/nrpe.cfg.erb"),
    notify => Service['nagios-nrpe-server']
   }
   file { "/etc/nagios/nrpe_local.cfg":
    owner  => 0, group  => 0, mode => 0644,
    content => template("${module_name}/nrpe_local.cfg.erb"),
    notify => Service['nagios-nrpe-server']
   }

   file { "/usr/lib/nagios/plugins/check_memory.pl":
    owner  => 0, group  => 0, mode => 0644,
    content => template("${module_name}/check_memory.pl"),
    notify => Service['nagios-nrpe-server']
   }

   service{'nagios-nrpe-server':
        ensure => running,
        hasrestart => true,
        hasstatus => true,
        restart => 'service nagios-nrpe-server restart'
        }

}
