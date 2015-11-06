#
class iptables::params {

  $input = {
    lan      => { ip => '10.0.0.0/8' },
    office   => { ip => 'office.bw-y.com' },
    puppet   => { ip => 'puppet.bw-y.com.com' },
    nagios   => { ip => 'monitor.bw-y.com' },
    gj_ip02  => { ip => '18.13.12.131/32' },
  }

}
