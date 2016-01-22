# Metrics Stack Puppet Profile

A profile to setup a basic metrics stack

Collectd -> Influxdb -> Grafana

![image](https://cloud.githubusercontent.com/assets/1064715/12520772/535fedbe-c13e-11e5-97aa-e5c2554ea69c.png)

# Instructions

vagrant up

# Example output
```
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'puppetlabs/centos-6.6-64-puppet'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'puppetlabs/centos-6.6-64-puppet' is up to date...
==> default: Setting the name of the VM: metrics-stack-puppet-profile_default_1453489459565_69105
==> default: Clearing any previously set network interfaces...
==> default: Available bridged network interfaces:
1) en0: Wi-Fi (AirPort)
2) en1: Thunderbolt 1
3) en2: Thunderbolt 2
4) bridge0
5) p2p0
6) awdl0
==> default: When choosing an interface, it is usually the one that is
==> default: being used to connect to the internet.
    default: Which interface should the network bridge to? 1
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: bridged
==> default: Forwarding ports...
    default: 22 => 2222 (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection timeout. Retrying...
    default: Warning: Remote connection disconnect. Retrying...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Setting hostname...
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
    default: /vagrant => /Users/petersouter/projects/metrics-stack-puppet-profile
==> default: Running provisioner: shell...
    default: Running: inline script
==> default: Loaded plugins: fastestmirror, security
==> default: Setting up Install Process
==> default: Loading mirror speeds from cached hostfile
==> default:  * base: mirrors.clouvider.net
==> default:  * extras: centos.hyve.com
==> default:  * updates: www.mirrorservice.org
==> default: Examining /var/tmp/yum-root-HbAVGr/ruby-2.1.2-2.el6.x86_64.rpm: ruby-2.1.2-2.el6.x86_64
==> default: Marking /var/tmp/yum-root-HbAVGr/ruby-2.1.2-2.el6.x86_64.rpm to be installed
==> default: Resolving Dependencies
==> default: --> Running transaction check
==> default: ---> Package epel-release.noarch 0:6-8 will be installed
==> default: ---> Package git.x86_64 0:1.7.1-3.el6_4.1 will be installed
==> default: --> Processing Dependency: perl-Git = 1.7.1-3.el6_4.1 for package: git-1.7.1-3.el6_4.1.x86_64
==> default: --> Processing Dependency: perl(Git) for package: git-1.7.1-3.el6_4.1.x86_64
==> default: --> Processing Dependency: perl(Error) for package: git-1.7.1-3.el6_4.1.x86_64
==> default: ---> Package ruby.x86_64 0:2.1.2-2.el6 will be installed
==> default: --> Processing Dependency: libyaml-0.so.2()(64bit) for package: ruby-2.1.2-2.el6.x86_64
==> default: --> Running transaction check
==> default: ---> Package libyaml.x86_64 0:0.1.3-4.el6_6 will be installed
==> default: ---> Package perl-Error.noarch 1:0.17015-4.el6 will be installed
==> default: ---> Package perl-Git.noarch 0:1.7.1-3.el6_4.1 will be installed
==> default: --> Finished Dependency Resolution
==> default:
==> default: Dependencies Resolved
==> default:
==> default: ================================================================================
==> default:  Package         Arch      Version            Repository                   Size
==> default: ================================================================================
==> default: Installing:
==> default:  epel-release    noarch    6-8                extras                       14 k
==> default:  git             x86_64    1.7.1-3.el6_4.1    base                        4.6 M
==> default:  ruby            x86_64    2.1.2-2.el6        /ruby-2.1.2-2.el6.x86_64     44 M
==> default: Installing for dependencies:
==> default:  libyaml         x86_64    0.1.3-4.el6_6      base                         52 k
==> default:  perl-Error      noarch    1:0.17015-4.el6    base                         29 k
==> default:  perl-Git        noarch    1.7.1-3.el6_4.1    base                         28 k
==> default:
==> default: Transaction Summary
==> default: ================================================================================
==> default: Install       6 Package(s)
==> default: Total size: 49 M
==> default: Total download size: 4.7 M
==> default: Installed size: 59 M
==> default: Downloading Packages:
==> default: --------------------------------------------------------------------------------
==> default: Total                                           2.8 MB/s | 4.7 MB     00:01
==> default: Running rpm_check_debug
==> default: Running Transaction Test
==> default: Transaction Test Succeeded
==> default: Running Transaction
  Installing : 1:perl-Error-0.17015-4.el6.noarch                            1/6
==> default:
  Installing : perl-Git-1.7.1-3.el6_4.1.noarch                              2/6
==> default:
  Installing : git-1.7.1-3.el6_4.1.x86_64                                   3/6
==> default:
  Installing : libyaml-0.1.3-4.el6_6.x86_64                                 4/6
==> default:
  Installing : ruby-2.1.2-2.el6.x86_64                                      5/6
==> default:
  Installing : epel-release-6-8.noarch                                      6/6
==> default:
  Verifying  : 1:perl-Error-0.17015-4.el6.noarch                            1/6
==> default:
  Verifying  : perl-Git-1.7.1-3.el6_4.1.noarch                              2/6
==> default:
  Verifying  : libyaml-0.1.3-4.el6_6.x86_64                                 3/6
==> default:
  Verifying  : epel-release-6-8.noarch                                      4/6
==> default:
  Verifying  : ruby-2.1.2-2.el6.x86_64                                      5/6
==> default:
  Verifying  : git-1.7.1-3.el6_4.1.x86_64                                   6/6
==> default:
==> default:
==> default: Installed:
==> default:   epel-release.noarch 0:6-8             git.x86_64 0:1.7.1-3.el6_4.1
==> default:   ruby.x86_64 0:2.1.2-2.el6
==> default:
==> default: Dependency Installed:
==> default:   libyaml.x86_64 0:0.1.3-4.el6_6         perl-Error.noarch 1:0.17015-4.el6
==> default:   perl-Git.noarch 0:1.7.1-3.el6_4.1
==> default: Complete!
==> default: invalid options: -SHN
==> default:
==> default: (invalid options are ignored)
==> default: Successfully installed colored-1.2
==> default: Successfully installed cri-2.6.1
==> default: Successfully installed log4r-1.1.10
==> default: Successfully installed multi_json-1.11.2
==> default: Successfully installed multipart-post-2.0.0
==> default: Successfully installed faraday-0.9.2
==> default: Successfully installed faraday_middleware-0.9.2
==> default: Successfully installed minitar-0.5.4
==> default: Successfully installed semantic_puppet-0.1.1
==> default: Successfully installed puppet_forge-2.1.2
==> default: Successfully installed faraday_middleware-multi_json-0.0.6
==> default: Successfully installed r10k-2.1.1
==> default: Parsing documentation for colored-1.2
==> default: Installing ri documentation for colored-1.2
==> default: Parsing documentation for cri-2.6.1
==> default: Installing ri documentation for cri-2.6.1
==> default: Parsing documentation for faraday-0.9.2
==> default: Installing ri documentation for faraday-0.9.2
==> default: Parsing documentation for faraday_middleware-0.9.2
==> default: Installing ri documentation for faraday_middleware-0.9.2
==> default: Parsing documentation for faraday_middleware-multi_json-0.0.6
==> default: Installing ri documentation for faraday_middleware-multi_json-0.0.6
==> default: Parsing documentation for log4r-1.1.10
==> default: Installing ri documentation for log4r-1.1.10
==> default: Parsing documentation for minitar-0.5.4
==> default: Installing ri documentation for minitar-0.5.4
==> default: Parsing documentation for multi_json-1.11.2
==> default: Installing ri documentation for multi_json-1.11.2
==> default: Parsing documentation for multipart-post-2.0.0
==> default: Installing ri documentation for multipart-post-2.0.0
==> default: Parsing documentation for puppet_forge-2.1.2
==> default: Installing ri documentation for puppet_forge-2.1.2
==> default: Parsing documentation for r10k-2.1.1
==> default: Installing ri documentation for r10k-2.1.1
==> default: Parsing documentation for semantic_puppet-0.1.1
==> default: Installing ri documentation for semantic_puppet-0.1.1
==> default: Done installing documentation for colored, cri, faraday, faraday_middleware, faraday_middleware-multi_json, log4r, minitar, multi_json, multipart-post, puppet_forge, r10k, semantic_puppet after 4 seconds
==> default: 12 gems installed
==> default: INFO	 -> Updating module /etc/puppetlabs/code/modules/stdlib
==> default: INFO	 -> Updating module /etc/puppetlabs/code/modules/collectd
==> default: INFO	 -> Updating module /etc/puppetlabs/code/modules/grafana
==> default: Notice: Compiled catalog for metrics-stack-puppet-profile.vm in environment production in 0.67 seconds
==> default: Notice: /Stage[main]/Main/Exec[/usr/bin/yum install http://dl.marmotte.net/rpms/redhat/el6/x86_64/collectd-5.5.0-1.el6/collectd-5.5.0-1.el6.x86_64.rpm -y]/returns: executed successfully
==> default: Notice: /Stage[main]/Collectd::Config/File[collectd.conf]/content: content changed '{md5}1f7adca3e4902542e29265914bb1ae70' to '{md5}ea9c88d5796a02b553d1af22c76edc77'
==> default: Notice: /Stage[main]/Collectd::Config/File[collectd.d]/ensure: created
==> default: Notice: /Stage[main]/Collectd::Service/Service[collectd]/ensure: ensure changed 'stopped' to 'running'
==> default: Notice: /Stage[main]/Main/Exec[/usr/bin/yum install http://influxdb.s3.amazonaws.com/influxdb-0.9.4.2-1.x86_64.rpm -y]/returns: executed successfully
==> default: Notice: /Stage[main]/Main/File[/etc/opt/influxdb/influxdb.conf]/content: content changed '{md5}16e259cd0b7f69be66c23dbed7d03b29' to '{md5}7844ce449a481425e559e1c06112ec39'
==> default: Notice: /Stage[main]/Main/Service[influxdb]/ensure: ensure changed 'stopped' to 'running'
==> default: Notice: /Stage[main]/Grafana::Install/Package[fontconfig]/ensure: created
==> default: Notice: /Stage[main]/Grafana::Install/Package[grafana]/ensure: created
==> default: Notice: /Stage[main]/Grafana::Config/File[/etc/grafana/grafana.ini]/content: content changed '{md5}182e0481c41858e299281d31996e6531' to '{md5}cc5712b4a99d20259b9e045e1015cf13'
==> default: Notice: /Stage[main]/Grafana::Service/Service[grafana-server]/ensure: ensure changed 'stopped' to 'running'
==> default: Notice: /Stage[main]/Main/Grafana_datasource[collectd]/ensure: created
==> default: Notice: /Stage[main]/Main/Grafana_dashboard[CollectD Stats]/ensure: created
==> default: Notice: Applied catalog in 47.94 seconds
==> default: Simulating some load to make the graphs more interesting
==> default: Loaded plugins: fastestmirror, security
==> default: Setting up Install Process
==> default: Loading mirror speeds from cached hostfile
==> default:  * base: mirrors.clouvider.net
==> default:  * epel: www.mirrorservice.org
==> default:  * extras: centos.hyve.com
==> default:  * updates: www.mirrorservice.org
==> default: Resolving Dependencies
==> default: --> Running transaction check
==> default: ---> Package stress.x86_64 0:1.0.4-4.el6 will be installed
==> default: --> Finished Dependency Resolution
==> default:
==> default: Dependencies Resolved
==> default:
==> default: ================================================================================
==> default:  Package          Arch             Version                 Repository      Size
==> default: ================================================================================
==> default: Installing:
==> default:  stress           x86_64           1.0.4-4.el6             epel            36 k
==> default:
==> default: Transaction Summary
==> default: ================================================================================
==> default: Install       1 Package(s)
==> default: Total download size: 36 k
==> default: Installed size: 89 k
==> default: Downloading Packages:
==> default: warning:
==> default: rpmts_HdrFromFdno: Header V3 RSA/SHA256 Signature, key ID 0608b895: NOKEY
==> default: Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
==> default: Importing GPG key 0x0608B895:
==> default:  Userid : EPEL (6) <epel@fedoraproject.org>
==> default:  Package: epel-release-6-8.noarch (@extras)
==> default:  From   : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
==> default: Running rpm_check_debug
==> default: Running Transaction Test
==> default: Transaction Test Succeeded
==> default: Running Transaction
==> default: Warning: RPMDB altered outside of yum.
  Installing : stress-1.0.4-4.el6.x86_64                                    1/1
==> default:
  Verifying  : stress-1.0.4-4.el6.x86_64                                    1/1
==> default:
==> default:
==> default: Installed:
==> default:   stress.x86_64 0:1.0.4-4.el6
==> default: Complete!
==> default: stress: info: [3747] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
==> default: stress: info: [3747] successful run completed in 60s
==> default: iptables: Setting chains to policy ACCEPT: filter
==> default: [  OK  ]
==> default: iptables: Flushing firewall rules:
==> default: [  OK  ]
==> default: iptables: Unloading modules:
==> default: [
==> default:   OK  ]
==> default: Grafana is running at http://192.168.0.47:3000
```

# TODO

* Refactor the monolith manifest into profiles
* Use an existing module to setup influxdb

![image](https://cloud.githubusercontent.com/assets/1064715/12520772/535fedbe-c13e-11e5-97aa-e5c2554ea69c.png)
