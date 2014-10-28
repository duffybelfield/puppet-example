#Run on non-master node to add checks
class icinga::observed {

 include icinga::packages
 include icinga::nrpe
   #Ping check
   @@nagios_host { "$ec2_ip":
       ensure => present,
       alias => $hostname,
       display_name => $hostname,
       address => $ec2_ip,
       use => "generic-host",
       require => Class['icinga::packages']
  }

 @@nagios_hostextinfo { $ec2_ip:
        ensure => present,
        icon_image_alt => $operatingsystem,
        icon_image => "base/ubuntu.png",
        statusmap_image => "base/ubuntu.gd2",
	require => Class['icinga::packages']
      }

  #SSHd Check
  @@nagios_service { "check_ssh_${ec2_ip}":
       check_command => "check_ssh!$ec2_ip",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "SSH",
       require => Class['icinga::packages']
  }

 #Check HTTP
 @@nagios_service { "check_http_${ec2_ip}":
       check_command => "check_http!$ec2_ip",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "HTTP",
       require => Class['icinga::packages']
  }

 #Check Users
 @@nagios_service { "check_users_${ec2_ip}":
       check_command => "check_nrpe!check_users!20!50",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "Check Users",
       require => Class['icinga::packages']
  }
 
 #Check Load   
 @@nagios_service { "check_load_${ec2_ip}":
       check_command => "check_nrpe!check_load!5.0!4.0!3.0!10.0!6.0!4.0",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "Check Load",
       require => Class['icinga::packages']
  }

#Check Processes  
 @@nagios_service { "check_procs_${ec2_ip}":
       check_command => "check_nrpe!check_procs!250!400",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "Total Processes",
       require => Class['icinga::packages']
  }

#Check Diskspace
 @@nagios_service { "check_diskspace_${ec2_ip}":
       check_command => "check_nrpe!check_all_disks!20%!10%",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "Check Disk Space",
       require => Class['icinga::packages']
  }

 #Check Memory
 @@nagios_service { "check_memory_${ec2_ip}":
       check_command => "check_nrpe!check_memory!50%!25%",
       use => "generic-service",
       host_name => "$ec2_ip",
       service_description => "Check Memory",
       require => Class['icinga::packages']
  }

}
