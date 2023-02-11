#!/bin/bash
terraform output -json | jq -r '.[].value[]' | jq -r '.[][] | { name: (.name + .tags.Name), public_ip: .public_ip, private_ip: .private_ip, public_dns: .public_dns, private_dns: .private_dns, id: .id, instance_type: .instance_type, availability_zone: .availability_zone, resource_group_name: .resource_group_name}' | jq -n '.instance |= [inputs]' 
