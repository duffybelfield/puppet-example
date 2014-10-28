class datadog {
exec { "install_key":
	command	=> 'DD_API_KEY=58bdcda486652331abda1b31c651739b bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"'

}

}
