class puppet {
  file { "/etc/puppet/puppet.conf":
    owner  => 0, group  => 0, mode => 0644,
    content => template("${module_name}/puppet.conf.erb"),
  }

  service { "puppet":
    name       => "puppet",
    ensure     => running,
    enable     => true, hasstatus  => true, hasrestart => true,
    require    => File["/etc/puppet/puppet.conf"]
  }

  cron { restart-puppet:
	command => "if [ -e /var/run/puppetd.pid ]; then ps uw -p `cat /var/run/puppetd.pid` | grep -q ' ruby /usr/sbin/puppetd' || (rm /var/run/puppetd.pid; /etc/init.d/puppet start); else /etc/init.d/puppet start; fi",
	user => root,
	minute => 0
  }
  service { cron:
	ensure => running,
	enable => true
  }
}
