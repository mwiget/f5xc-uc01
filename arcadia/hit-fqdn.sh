#!/bin/bash

#set -o errexit
#
fqdn="arcadia.acmecorp-prod.f5xc.app"
echo "quering public url $fqdn 5 times ..."

#header="-H \"user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36\""

for i in {1..50}; do
  curl -v -s $header -X POST https://${fqdn}/trading/auth.php -H '{Content-Type: application/x-www-form-urlencoded' -d 'username=matt&password=ilovef5'
  curl -v -s $header https://${fqdn}/trading/index.php 
  curl -v -s $header https://${fqdn}/trading/logout.php
  sleep 1; 
done
exit

export KUBECONFIG=../sites/kubeconfig

workloads=$(terraform output -json | jq -r '.[].value[]' | jq -r '.[][] | .private_ip' | tr '\n' ' ')
echo "workload private_ip: $workloads"

alpine_tgw1=$(kubectl get pods -o json | jq -r '.items[] | select(.metadata.annotations["ves.io/sites"] == "system/vela-tgw1") .metadata.name')
#echo "tgw1  $alpine_tgw1"
alpine_tgw2=$(kubectl get pods -o json | jq -r '.items[] | select(.metadata.annotations["ves.io/sites"] == "system/vela-tgw2") .metadata.name')
#echo "tgw2  $alpine_tgw2"
alpine_vnet1=$(kubectl get pods -o json | jq -r '.items[] | select(.metadata.annotations["ves.io/sites"] == "system/vela-vnet1") .metadata.name')
#echo "vnet1 $alpine_vnet1"
#echo ""

for site in tgw1 tgw2 vnet1; do
  pod="alpine_$site"
  echo "ping from site $site (${!pod}) ..."
     kubectl exec ${!pod} -c alpine -- ash -c "for ip in $workloads; do /usr/sbin/fping -c5 -q -i1 \$ip; done"
  echo ""
done
