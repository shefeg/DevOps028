#!/bin/bash
for i in `/usr/bin/aws ec2 describe-instances --filters "Name=tag-value,Values=${params.INSTANCE_NAME}" | grep "InstanceId" | cut -d':' -f2 | tr -d '", '`; do aws ec2 terminate-instances --instance-ids $i; done;