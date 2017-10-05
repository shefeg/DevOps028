#!/bin/bash

#aws rds create-db-instance \
#--db-instance-identifier $INSTANCE_NAME \
#--engine $DB_ENGINE \
#--allocated-storage $SIZE \
#--db-instance-class $INSTANCE_TYPE \
#--db-name $DB_NAME \
#--master-username $DB_USER \
#--master-user-password $DB_PASSWORD \
#--availability-zone $AVAILABILITY_ZONE \
#--backup-retention-period $BACKUP_RETENTION

while [ `aws rds describe-db-instances --db-instance-identifier $INSTANCE_NAME | grep available | cut -d':' -f2 | tr -d '", '` != "available" ]; do sleep 10; done && $DB_HOST=$(aws rds describe-db-instances --db-instance-identifier $INSTANCE_NAME | grep available | cut -d':' -f2 | tr -d '", ')
echo $DB_HOST