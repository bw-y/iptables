# iptables

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

此模块用于管理节点的防火墙规则

## Usage

```
例1 忽略当前节点的iptables,不做任何操作
node 'node1.bw-y.com' {
  class { '::iptables': }
}
```

```
例2 清空当前节点的iptables规则
node 'node1.bw-y.com' {
  class { '::iptables': 
    ipt_ensure => 'stopped',
  }
}
```

```
例3: 
  1) 开启iptable
  2) 并配置允许来自bw-y.com的请求
  3) 开启nat表snat链POSTROUTEING表的masq转发
  4) 配置一个snat规则
  5) 配置一个dnat规则
    示例如下:   
node 'node1.bw-y.com' {
  class { '::iptables': 
    ipt_ensure   => 'running',
    snat_masq    => 'present',
    input_custom => {
      'allow_bw-y' => { ip => 'bw-y.com' }
    },
    snat         => {
      'test1_snat' => {
        source   => '192.168.1.0/24',
        tosource => '10.4.0.21',
      }
    },
    dnat         => {
      test1_dnat  => {
        destination => '18.13.192.130/32',
        dport       => '22103',
        todest      => '10.7.0.44:22',
      }
    }
  }
}
```
 
## Reference

* iptables::install : 安装和管理ipbtales纯规则之外的约束
* iptables::params : 参数类，目前仅用于默认input规则存放
* iptables::base : 一些基础共用规则设置
* iptables::config : 关联参数和资源的关系

### Define resouces

* iptables::resource::input: input的define资源,设置一些必选项默认值,便于复用
* iptables::resource::dnat: dnat的define资源,设置一些必选项默认值,便于复用
* iptables::resource::snat: snat的define资源,设置一些必选项默认值,便于复用

### Parameters

#### `ipt_ensure`
[可选项] 引用iptables模块后的iptables全局开关. 有效值[ignore|running|stopped], ignore:不做任何操作; running: 应用默认规则和自定义规则; stopped清除节点所有iptables规则. 默认值: ignore

#### `ipt_purge`
[可选项] 是否删除非puppet管理的iptables规则. 有效值[true(删除)|false(不删除)]. 默认值: false

#### `tcp_ports`
[可选项] 设置到filter表input链的tcp开放端口. 有效数据类型为数字数组. 默认值: [53,80,443,8080,873]

#### `udp_ports` 
[可选项] 设置到filter表input链的udp开放端口. 有效数据类型为数字数组. 默认值: [53]

#### `snat_masq`
[可选项] 是否打开nat表的POSTROUTING链的MASQUERADE规则. 有效值[present(打开)|absent(不打开)]. 默认值: absent

#### `input`
[可选项] 用于设置默认开放ip或fqdn的hash字典. 有效值为一个一层的嵌套hash字典, 有效字典key见iptables::resource::input的文件头的说明文档. 默认值: $::iptables::params::input (除完全要使用页面管理默认外,强烈不建议修改此项)

#### `input_defaults`
[可选项] input参数的默认值. 默认值: {}

#### `input_custom`
[可选项] 用于设置自定义的开放ip,和input参数的唯一区别是,此参数无默认值,仅用于被自定义调用. 默认值: {}

#### `input_custom_defaults`
[可选项] input_custom参数的默认值. 默认值: {}

#### `dnat`
[可选项] 设置dnat规则,有效值为一个一层的嵌套hash字典, 有效字典key见iptables::resource::dnat的文件头的说明文档. 默认值: {}

#### `dnat_defaults`
[可选项] 设置dnat参数的默认值. 默认值: {}

#### `snat`
[可选项] 设置snat规则,有效值为一个一层的嵌套hash字典, 有效字典key见iptables::resource::snat的文件头的说明文档. 默认值: {}

#### `snat_defaults`
[可选项] 设置snat参数的默认值. 默认值: {}

#### `stage`
[可选项] iptables模块的运行顺序. 默认值: runtime

## Limitations

目前支持系统(facter operatingsystem): Ubuntu/Redhat/CentOS 
