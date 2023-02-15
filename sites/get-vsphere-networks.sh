#!/bin/bash
echo "processing vsphere networks ..."
cp /dev/null /tmp/networks.json$$
for site in vsphere1; do
  terraform output -json | jq -r ".$site.value.network" \
  | tee -a /tmp/networks.json$$
done
cat /tmp/networks.json$$  | jq -n '.network |= [inputs]' > networks-vsphere.json
rm /tmp/networks.json$$
