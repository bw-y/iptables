#
define iptables::resource::dnat(
  $ensure      = present,
  $order       = '003',
  $proto       = 'tcp',
  $action      = 'accept',
  $source      = undef,
  $todest      = undef,
  $dport       = undef,
  $destination = undef,
  $provider    = 'iptables',
){
 
  firewall { "${order} dnat ${name}":
    ensure      => $ensure,
    proto       => $proto,
    source      => $source,
    dport       => $dport,
    todest      => $todest,
    destination => $destination,
    provider    => $provider,
    chain       => 'PREROUTING',
    jump        => 'DNAT',
    table       => 'nat',
  }

}
