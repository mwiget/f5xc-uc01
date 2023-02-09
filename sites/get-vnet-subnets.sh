#!/bin/bash
echo "processing azure vnet spoke subnets ..."
for spoke in spoke_vnet_a spoke_vnet_b; do
  terraform output -json | jq -r ".$spoke.value \
    | { resource_group: .resource_group.resource_group.name, vnet_name: .vnet.name, vnet_id: .vnet.id, address_space: .vnet.address_space[0], subnet_name: .subnet.subnet.name, address_prefix: .subnet.subnet.address_prefixes[0], subnet_id: .subnet.subnet.id, security_group: .vnet.subnet[0].security_group }" \
  | tee -a /tmp/subnets.json$$
done
cat /tmp/subnets.json$$  | jq -n '.subnets |= [inputs]' > subnets-vnet-spoke.json
rm /tmp/subnets.json$$
