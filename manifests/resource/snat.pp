#
define iptables::resource::snat(
  $ensure      = present,
  $order       = '001',
  $proto       = 'all',
  $source      = undef,
  $outiface    = undef,
  $tosource    = undef,
  $destination = undef,
){

  firewall { "${order} snat ${name}":
    ensure      => $ensure,
    chain       => 'POSTROUTING',
    jump        => 'SNAT',
    table       => 'nat',
    proto       => $proto,
    outiface    => $outiface,
    source      => $source,
    tosource    => $tosource,
    destination => $destination,
  } 

}
