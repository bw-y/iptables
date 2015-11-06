#
class iptables::config {

  create_resources ('iptables::resource::input',
    $::iptables::input, $::iptables::input_defaults)

  create_resources ('iptables::resource::input',
    $::iptables::input_custom, $::iptables::input_custom_defaults)

  create_resources ('iptables::resource::dnat',
    $::iptables::dnat, $::iptables::dnat_defaults)

  create_resources ('iptables::resource::snat',
    $::iptables::snat, $::iptables::snat_defaults)
}
