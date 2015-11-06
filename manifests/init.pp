#
class iptables (

  $ipt_ensure = 'ignore',
  $ipt_purge  = false,
  $tcp_ports  = [53,80,443,8080,873],
  $udp_ports  = [53],
  $snat_masq  = absent,

  $input_defaults        = {},
  $input                 = $::iptables::params::input,
  $input_custom_defaults = {},
  $input_custom          = {},

  $dnat_defaults         = {},
  $dnat                  = {},

  $snat_defaults         = {},
  $snat                  = {},

  $stage                 = 'runtime',
) inherits ::iptables::params {

  if !($::virtual in ['lxc','docker']) {
    case $ipt_ensure {
      'running': {
        anchor { 'iptables::begin': } ->
        class { '::iptables::install': } ->
        class { '::iptables::base': } ->
        class { '::iptables::config': } ->
        class { '::iptables::limit': }
        anchor { 'iptables::end': }
      }
      'stopped': {
        include ::iptables::install
      }
      'ignore': {
        # nothing
      }
      default: {
        fail("${title}: Ensure value '${ipt_ensure}' is not supported")
      }
    }
  }
}
