# hashi-learn

 * [learn.hashicorp.com](https://learn.hashicorp.com/)
 * [Youtube - Hashicorp channel](https://www.youtube.com/HashiCorp)


## Consul

Consul runs a DNS server (tcp and udp) on port 8600 and a HTTP server for the API on port 8500.

```bash
consul agent -dev -node server01
consul members
consul catalog nodes -detailed  # or
curl localhost:8500/v1/catalog/nodes  # or
dig @localhost -p 8600 server01.node.consul
```
After running a particular `service` this can be tracked by the following:

```bash
dig @localhost -p 8600 web.service.consul
# To get the server running that  service
dig @localhost -p 8600 web.service.consul SRV 

curl localhost:8500/v1/catalog/services  
curl localhost:8500/v1/catalog/service/web  
```

## Nomad

**Nomad needs consul in order to work correctly.** To use the portforwarding in order to view the webinterface of Nomad, make Nomad start with a bind address to `0.0.0.0`.

```bash
consul agent -dev
nomad agent -dev -bind=0.0.0.0
```
To build a example Nomad job execute `nomad job init`. This should generate a file named *example.nomad* with a job that starts a docker container for a redis-cache server. To test that job execute:
```bash
nomad job run example.nomad
```
Modify the *example.nomad* file, for example change count from `1` to `3`
```bash
    # The "count" parameter specifies the number of the task groups that should
    # be running under this group. This value must be non-negative and defaults
    # to 1.
    count = 3
```
Test the nomad file, 'plan' the job and finally make the changes. See [the Nomad tutorial](https://learn.hashicorp.com/nomad/getting-started/jobs) for more information.

```bash
nomad job plan example.nomad
nomad job run -check-index <nr> example.nomad
```

Example nomad job:
```json 
job "example" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }
  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }
  group "cache" {
    count = 1
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    ephemeral_disk {
      size = 300
    }
    task "redis" {
      driver = "docker"
      config {
        image = "redis:3.2"
        port_map {
          db = 6379
        }
      }
      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 10
          port "db" {}
        }
      }
      service {
        name = "redis-cache"
        tags = ["global", "cache"]
        port = "db"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
```

## Vault

Vault can run on itself. To check if it is running
``` bash
vault status
```

There are multiple ways of storing information in Vault. The easiest most straightforward way is the use of a key-value store.
To put information in the Vault
``` bash
vault kv put secret/hello foo=world
#Key              Value
#---              -----
#created_time     2019-11-01T07:09:45.130719984Z
#deletion_time    n/a
#destroyed        false
#version          1
```
This will create a key-value pair of ``foo=world`` in a path located at ``secret/hello``.

To get information from Vault you need the path of the information you want to retrieve.
```bash
vault kv list secret
#Keys
#----
#hello
```
Then the secret information can be retreived by
```bash
vault kv get secret/hello
#====== Metadata ======
#Key              Value
#---              -----
#created_time     2019-11-01T07:09:45.130719984Z
#deletion_time    n/a
#destroyed        false
#version          1
#
#=== Data ===
#Key    Value
#---    -----
#foo    world
```

Vault needs an environment variable in order to authenticate commands against the running Vault service.
The variable is stored as ``VAULT_DEV_ROOT_TOKEN_ID``. Since the Vault service is started with the system during boot the cli is already authenticated.
If by any event you need that token it can be found in the systemctl logging framework journalctl.

```bash
journalctl -u vault.service | grep Token
```

## Hashi-UI
The Hashi-UI interface is slightly more sophisticated than the default webinterface of Nomad. In addition Consul can also be accessed by Hashi-UI. 
The Hashi-UI interface is running by default on port ``3000``. 
For the Vagrant setup:

 * The Nomad interface can be accessed on: ``localhost:4646``;
 * The Hashi-UI interface can be accessed on: ``localhost:3000``;
 * The Vault interface can be accessed on: ``localhost:8201``;

