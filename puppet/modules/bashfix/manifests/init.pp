class bashfix {

exec { "update":
    path => ["/usr/bin/","/usr/sbin/","/bin"],
    command => "apt-get update",
    user => root,
}

exec { "upgrade bash":
    path => ["/usr/bin/","/usr/sbin/","/bin"],
    command => "apt-get install bash",
    user => root,
}


}
