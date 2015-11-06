#
class iptables::base {
  Firewall {
    proto     => 'all',
    action    => 'accept',
  }

  firewall { '000 accept all icmp':
    proto => 'icmp'
  }

  firewall { '001 accept all to lo interface':
    iniface => 'lo'
  }

  firewall { '002 accept related established rules':
    state => ['RELATED', 'ESTABLISHED']
  }

  firewall { '003 accept wan ip 1':
    source => '180.169.18.130/32'
  }

  firewall { '003 accept wan ip 2':
    source => '180.153.192.130/32'
  }

  firewall { '004 allow default tcp ports':
    proto => tcp,
    dport => $::iptables::tcp_ports,
  }

  firewall { '005 allow default udp ports':
    proto => udp,
    dport => $::iptables::udp_ports,
  }

  firewall { '999 snat masquerade':
    ensure => $::iptables::snat_masq,
    chain  => 'POSTROUTING',
    jump   => 'MASQUERADE',
    proto  => 'all',
    table  => 'nat',
    action => undef,
  }
}
