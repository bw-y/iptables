#
class iptables::install {

  # true: ubuntu/12.04|10.04 的输出巨多的bug:
  # 目前怀疑为create_resources/resources/firewall三者资源间的调度影响
  # 确认测试可暂时放到后期(考虑create_resources直接引用firewall)
  resources { 'firewall': purge => $::iptables::ipt_purge }

  if $::iptables::ipt_ensure in ['running','stopped'] {
    class { '::firewall': ensure => $::iptables::ipt_ensure }
  }
  
  if ($::operatingsystem == 'Ubuntu' and $::iptables::ipt_ensure == 'stopped'){
    exec { 'clean rules':
      path    => '/usr/sbin:/usr/bin:/sbin:/bin',
      command => 'iptables -t nat -F ; iptables -F',
      unless  => "test \$(iptables -t nat -nvL|wc -l) \
-eq 11 || test \$(iptables -t nat -nvL|wc -l) -eq 8",    
    }
  }

}
