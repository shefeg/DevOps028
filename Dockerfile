FROM openjdk:8

RUN mkdir -p /samsara/liquibase

WORKDIR /samsara

COPY jenkins/run_app.sh .
COPY target/Samsara-1.3.5.RELEASE.jar .
COPY liquibase ./liquibase

ENV DB_HOST=aidemo2.cxrpxm1cr8gt.us-east-1.rds.amazonaws.com
ENV DB_NAME=auradb
ENV DB_USER=aura
ENV DB_PASSWORD=mysecretpassword

ENTRYPOINT ["bash", "/samsara/run_app.sh"]

EXPOSE 9000