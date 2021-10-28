# Instance pool with network load balancer

This example will deploy:

* one instance configuration used by the instance pool
* one instance pool
* two Oracle compute instances launched by the instance pool
* one network load balancer, that will route the traffic from the internet to our instance pool instances

The network load balancer is made by:

* one listener (port 80)
* one backed set
* one backed for each of the instances in the instance pool

### Extra variables

In this example an extra variable is used:

* fault_domains. This variable is a list of fault domains where our instance pool will deploy our instances
* instance_pool_size. Number of instances to launch in the instance pool

### Deploy

To deploy the infrastructure:

```
terraform init

terraform plan

terraform apply
```

wait terraform to complete the operation, when terraform successfully finished the deployment you will see in the output the public ip addresses of the instances and the public ip address of the network load balancer:

```
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

instances_ips = [
  "152.x.x.x",
  "152.x.x.x",
]
lb_ip = tolist([
  {
    "ip_address" = "152.x.x.x"
    "is_public" = true
    "reserved_ip" = tolist([])
  },
])
```

now you can ssh into the machine:

```
ssh ubuntu@152.x.x.x

...
35 updates can be applied immediately.
25 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@inst-ikudx-ubuntu-instance-pool:~$
```

Test the connection to the load balancer:

```
curl -v 152.x.x.x
*   Trying 152.x.x.x:80...
* TCP_NODELAY set
* Connected to 152.x.x.x (152.x.x.x) port 80 (#0)
> GET / HTTP/1.1
> Host: 152.x.x.x
> User-Agent: curl/7.68.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: nginx/1.18.0 (Ubuntu)
< Date: Wed, 27 Oct 2021 15:39:51 GMT
< Content-Type: text/html
< Content-Length: 672
< Last-Modified: Wed, 27 Oct 2021 15:33:26 GMT
< Connection: keep-alive
< ETag: "61797146-2a0"
< Accept-Ranges: bytes
...
...
...
```

**NOTE** You have to wait all the backends to be in HEALTH state before reaching successfully the load balancer.

### Cleanup

```
terraform destroy
```