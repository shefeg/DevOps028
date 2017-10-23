FROM openjdk:8

RUN mkdir -p /samsara

WORKDIR /samsara

COPY jenkins/populate_db.sh .
COPY target/Samsara-1.3.5.RELEASE.jar .
COPY liquibase .

ENV DB_HOST=aidemo2.cxrpxm1cr8gt.us-east-1.rds.amazonaws.com \
    DB_NAME=auradb \
    DB_USER=aura \
    DB_PASS=mysecretpassword

ENTRYPOINT ["bash", "/samsara/populate_db.sh"]

EXPOSE 9000