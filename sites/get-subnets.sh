#!/bin/bash
cp /dev/null /tmp/subnets.json$$
for spoke in spoke11 spoke12; do
  terraform output -json | jq -r ".$spoke.value.aws_subnet[] \
  | { subnet_name: .tags_all.Name, subnet_id: .id, vpc_id:.vpc_id, availability_zone: .availability_zone, security_group_id: .tags_all.security_group_id}" \
  | tee -a /tmp/subnets.json$$
done
cat /tmp/subnets.json$$  | jq -n '.subnets |= [inputs]' > subnets-spoke-us-west-2.json
rm /tmp/subnets.json$$
ls -l subnets-spoke.json
