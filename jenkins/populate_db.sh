#!/usr/bin/env bash

#Create liquibase.properties file and add parameters
cat > liquibase/liquibase.properties << EOF
driver: org.postgresql.Driver
url: jdbc:postgresql://$DB_HOST:5432/$DB_NAME
username: $DB_USER
password: $DB_PASS
# specifies packages where entities are and database dialect, used for liquibase:diff command
referenceUrl=hibernate:spring:academy.softserve.aura.core.entity?dialect=org.hibernate.dialect.PostgreSQL9Dialect
EOF

#Download liquibase tool and postgresql jdbc driver
wget https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.5.3/liquibase-3.5.3-bin.tar.gz
wget https://jdbc.postgresql.org/download/postgresql-42.1.4.jar

#Untar Liquibase tool and run it
tar -xf liquibase-3.5.3-bin.tar.gz -C liquibase
liquibase/liquibase --defaultsFile=liquibase/liquibase.properties --changeLogFile=liquibase/changelogs/changelog-main.xml --classpath=postgresql-42.1.4.jar update
java -jar /samsara/Samsara-1.3.5.RELEASE.jar
