#!/bin/bash

# Disable firewall 
/usr/sbin/netfilter-persistent stop
/usr/sbin/netfilter-persistent flush

systemctl stop netfilter-persistent.service
systemctl disable netfilter-persistent.service

# END Disable firewall

apt-get update
apt-get install -y software-properties-common jq
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

local_ip=$(curl -s -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/vnics/ | jq -r '.[0].privateIp')
flannel_iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)')

echo "Cluster init!"
until (curl -sfL https://get.k3s.io | K3S_TOKEN=${k3s_token} sh -s - --node-ip $local_ip --advertise-address $local_ip --flannel-iface $flannel_iface); do
    echo 'k3s did not install correctly'
    sleep 2
done

%{ if is_k3s_server }
until kubectl get pods -A | grep 'Running'; do
  echo 'Waiting for k3s startup'
  sleep 5
done

%{ if install_longhorn }
wget  https://raw.githubusercontent.com/longhorn/longhorn/${longhorn_release}/deploy/longhorn.yaml
sed -i 's/#- name: KUBELET_ROOT_DIR/- name: KUBELET_ROOT_DIR/g' longhorn.yaml
sed -i 's/#  value: \/var\/lib\/rancher\/k3s\/agent\/kubelet/  value: \/var\/lib\/kubelet/g' longhorn.yaml 

kubectl apply -f longhorn.yaml
%{ endif }

%{ endif }