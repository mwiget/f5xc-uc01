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
