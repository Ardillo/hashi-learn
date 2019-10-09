# hashi-learn

 * [learn.hashicorp.com](https://learn.hashicorp.com/)
 * [Youtube - Hashicorp channel](https://www.youtube.com/HashiCorp)


## Consul

Consul runs a DNS server (tcp and udp) on port 8600 and a HTTP server for the API on port 8500.

``` bash
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




