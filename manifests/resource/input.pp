#
define iptables::resource::input(
  $ensure      = present,
  $order       = '003',
  $proto       = 'all',
  $action      = 'accept',
  $ip          = '10.0.0.0/8',
  $dport       = undef,
  $sport       = undef,
  $state       = undef,
  $tcp_flags   = undef,
  $destination = undef,
){
 
  firewall { "${order} ${action} ${name}":
    ensure      => $ensure,
    action      => $action,
    proto       => $proto,
    source      => $ip,
    dport       => $dport,
    state       => $state,
    tcp_flags   => $tcp_flags,
    destination => $destination,
  }

}
