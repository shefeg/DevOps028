FROM openjdk:8

RUN mkdir -p /samsara/liquibase

WORKDIR /samsara

COPY jenkins/populate_db.sh .
COPY target/Samsara-1.3.5.RELEASE.jar .
COPY liquibase ./liquibase

ENV DB_HOST=aidemo2.cxrpxm1cr8gt.us-east-1.rds.amazonaws.com
ENV DB_NAME=auradb
ENV DB_USER=aura
ENV DB_PASS=mysecretpassword

ENTRYPOINT ["bash", "/samsara/populate_db.sh"]

EXPOSE 9000