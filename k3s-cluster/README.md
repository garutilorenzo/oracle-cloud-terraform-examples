# k3s cluster

This example will deploy:

* one Oracle compute instance, k3s-server
* one instance configuration used by the instance pool
* one instance pool
* three Oracle compute instances launched by the instance pool, k3s-agents
* one network load balancer, that will route the traffic from the internet to our instance pool instances

The network load balancer is made by:

* two listener (port 80, and 443)
* two backed set, one for the http listener and one for the https listener
* one backed for each of the instances in the instance pool

The traffic is routed from the internet to the traefik ingress controller.

### Extra variables

In this example an extra variable is used:

* k3s_server_private_ip, private ip address that will be associated to the k3s-server
* fault_domains, this variable is a list of fault domains where our instance pool will deploy our instances
* instance_pool_size, number of instances to launch in the instance pool. Number of k3s agents to deploy
* k3s_token, token used to install the k3s cluster
* install_longhorn, boolean value, if true (default) will install [longhorn](https://longhorn.io/) block storage 
* longhorn_release, longorn release version

### Deploy

To deploy the infrastructure:

```
terraform init

terraform plan

terraform apply
```

wait terraform to complete the operation, when terraform successfully finished the deployment you will see in the output the public ip addresses of the k3s-server instance, the public ip addresses of the k3s-agents instances and the public ip address of the network load balancer:

```
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

k3s_server_ip = "152.x.x.x"
k3s_agents_ips = [
  "152.x.x.x",
  "152.x.x.x",
  "152.x.x.x",
]
lb_ip = tolist([
  {
    "ip_address" = "133.x.x.x"
    "is_public" = true
    "reserved_ip" = tolist([])
  },
])
```

now you can ssh into the k3s-server machine:

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

ubuntu@k3s-server:~$
```

Test the connection to the load balancer:

```
curl -v http://132.x.x.x/
*   Trying 132.x.x.x:80...
* TCP_NODELAY set
* Connected to 132.x.x.x (132.x.x.x) port 80 (#0)
> GET / HTTP/1.1
> Host: 132.x.x.x
> User-Agent: curl/7.68.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
< Content-Type: text/plain; charset=utf-8
< X-Content-Type-Options: nosniff
< Date: Wed, 27 Oct 2021 13:20:05 GMT
< Content-Length: 19
< 
404 page not found
* Connection #0 to host 132.x.x.x left intact
```

**NOTE** You have to wait all the backends to be in HEALTH state before reaching successfully the load balancer.

**NOTE 2** 404 is a correct response since there are no deployment yet

### Cluster management

To manage the cluster, open a ssh connection to the k3s-server.

**List the nodes**

```
root@k3s-server:~# kubectl get nodes
NAME                    STATUS   ROLES                  AGE   VERSION
inst-vr4sv-k3s-agents   Ready    <none>                 23m   v1.21.5+k3s2
inst-zkcyl-k3s-agents   Ready    <none>                 23m   v1.21.5+k3s2
k3s-server              Ready    control-plane,master   23m   v1.21.5+k3s2
inst-fhayc-k3s-agents   Ready    <none>                 23m   v1.21.5+k3s2
```

**Get the pods running on kube-system namespace**

```
kubectl get pods -n kube-system
NAME                                      READY   STATUS      RESTARTS   AGE
coredns-7448499f4d-jwgzt                  1/1     Running     0          34m
metrics-server-86cbb8457f-qjgr9           1/1     Running     0          34m
local-path-provisioner-5ff76fc89d-56c7n   1/1     Running     0          34m
helm-install-traefik-crd-9ftr8            0/1     Completed   0          34m
helm-install-traefik-2v48n                0/1     Completed   2          34m
svclb-traefik-2x9q9                       2/2     Running     0          33m
svclb-traefik-d72cf                       2/2     Running     0          33m
svclb-traefik-jq5wv                       2/2     Running     0          33m
svclb-traefik-xnhgs                       2/2     Running     0          33m
traefik-97b44b794-4dz2x                   1/1     Running     0          33m
```

**Get the pods running on longhorn-system namespace (optional)**

```
root@k3s-server:~# kubectl get pods -n longhorn-system
NAME                                        READY   STATUS             RESTARTS   AGE
longhorn-ui-788fd8cf9d-76x84                1/1     Running            0          29m
longhorn-manager-97vzd                      1/1     Running            0          29m
longhorn-driver-deployer-5dff5c7554-c7wbk   1/1     Running            0          29m
longhorn-manager-sq2xn                      1/1     Running            1          29m
csi-attacher-75588bff58-xv9sn               1/1     Running            0          28m
csi-resizer-5c88bfd4cf-ngm2j                1/1     Running            0          28m
engine-image-ei-d4c780c6-ktvs7              1/1     Running            0          28m
csi-provisioner-669c8cc698-mqvjx            1/1     Running            0          28m
longhorn-csi-plugin-9x5wj                   2/2     Running            0          28m
engine-image-ei-d4c780c6-r7r2t              1/1     Running            0          28m
csi-provisioner-669c8cc698-tvs9r            1/1     Running            0          28m
csi-resizer-5c88bfd4cf-h8g6w                1/1     Running            0          28m
instance-manager-e-7aca498c                 1/1     Running            0          28m
instance-manager-r-98153684                 1/1     Running            0          28m
longhorn-csi-plugin-wf24d                   2/2     Running            0          28m
csi-snapshotter-69f8bc8dcf-n85hq            1/1     Running            0          28m
longhorn-csi-plugin-82hv5                   2/2     Running            0          28m
longhorn-csi-plugin-rlcw2                   2/2     Running            0          28m
longhorn-manager-rttww                      1/1     Running            1          29m
instance-manager-e-e43d97f9                 1/1     Running            0          28m
longhorn-manager-47zxl                      1/1     Running            1          29m
instance-manager-r-de0dc83b                 1/1     Running            0          28m
engine-image-ei-d4c780c6-hp4mb              1/1     Running            0          28m
engine-image-ei-d4c780c6-hcwpg              1/1     Running            0          28m
instance-manager-r-464299ad                 1/1     Running            0          28m
instance-manager-e-ccb8666b                 1/1     Running            0          28m
instance-manager-r-3b35070e                 1/1     Running            0          28m
instance-manager-e-9d117ead                 1/1     Running            0          28m
```