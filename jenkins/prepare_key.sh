#!/bin/bash
/usr/bin/aws ssm get-parameters --names "aipk" | grep "Value" | cut -d':' -f2 | tr -d '",' > aipk.pem
sed -i 's/\\n/\n/g' aipk.pem && sed -i '1s/ //' aipk.pem
chmod 600 aipk.pem
echo "SSH key prepared for using"