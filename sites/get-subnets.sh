#!/bin/bash
echo "processing tgw spoke subnets ..."
cp /dev/null /tmp/subnets.json$$
for spoke in spoke11 spoke12 spoke21 spoke22; do
  terraform output -json | jq -r ".$spoke.value.aws_subnet[] \
  | { subnet_name: .tags_all.Name, subnet_id: .id, vpc_id:.vpc_id, availability_zone: .availability_zone, security_group_id: .tags_all.security_group_id}" \
  | tee -a /tmp/subnets.json$$
done
cat /tmp/subnets.json$$  | jq -n '.subnets |= [inputs]' > subnets-tgw-spoke.json
rm /tmp/subnets.json$$
echo ""
echo "processing azure vnet spoke subnets ..."
for spoke in spoke_vnet_a spoke_vnet_b; do
  terraform output -json | jq -r ".$spoke.value \
  | { resource_group: .resource_group.resource_group.name, vnet_id: .vnet.id, address_space:.vnet.address_space[0], subnet_name: .vnet.subnet[0].name, subnet_id: .vnet.subnet[0].id, address_prefix: .vnet.subnet[0].address_prefix, security_group: .vnet.subnet[0].security_group }" \
  | tee -a /tmp/subnets.json$$
done
cat /tmp/subnets.json$$  | jq -n '.subnets |= [inputs]' > subnets-vnet-spoke.json
rm /tmp/subnets.json$$

ls -l subnets-*.json
