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

# TODO

 * Make unit files to start the Consul,Nomad,etc sesrvices with systemctl




