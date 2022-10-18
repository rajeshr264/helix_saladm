plan helix_saladm::install (
  TargetSpec $server,
  TargetSpec $client) {

    # Install the puppet-agent package and gather facts
    $client.apply_prep
    $server.apply_prep

  # Install p4d
  $server_apply_results = apply($server) {
    # Install the puppet-agent package and gather facts

    # install the p4 packages first using YUM
    file { '/etc/yum.repos.d/perforce.repo':
      ensure  => absent,
      replace => 'no', # this is the important property
      content => "[perforce]\n
      name=Perforce\n
      baseurl=http://package.perforce.com/yum/rhel/{version}/x86_64 \n
      enabled=1 \n
      gpgcheck=1\n",
      mode    => '0644',
    }

    # install p4 server 
    class { 'helix::server':
      pkgname => 'helix-p4d',
    }

    helix::server_instance { 'server1':
      p4port => '1666',
    }
  }
  run_task('helix_saladm::print_completed',$server, message => "server")

  $client_apply_results = apply($client) {

    # install p4 client
    class { 'helix::client':
      pkgname => 'helix-cli',
    }
  }
  run_task('helix_saladm::print_completed',$client, message => "client")
}
