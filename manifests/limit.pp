#
class iptables::limit{

  firewall { '999 drop all':
    proto     => 'all',
    action    => 'drop'
  }
  firewall { '997 drop tcp flags':
    proto     => 'tcp',
    tcp_flags => ['FIN SYN'],
    action    => 'drop'
  }
  firewall { '998 drop tcp flags':
    proto     => 'tcp',
    tcp_flags => ['RST ACK'],
    action    => 'drop'
  }

}
