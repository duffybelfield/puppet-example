node 'puppet'{
	include icinga::icinga

}


# UAT MACHINES
node /uat/{
     include puppet
     package { "htop": ensure  => "installed" }
     include icinga::observed
 #   class { 'apache':  }
 #   include 'awstats'
}

node default{
     include puppet
     package { "htop": ensure  => "installed" }
     include icinga::observed
 #   class { 'apache':  }
 #   include 'awstats'
}

