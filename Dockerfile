FROM openjdk:8
WORKDIR /var/lib/jenkins/DevOps028

# Environment Variables
ENV DB_HOST=aidemo2.cxrpxm1cr8gt.us-east-1.rds.amazonaws.com \
    DB_NAME=auradb \
    DB_USER=aura \
    DB_PASS=mysecretpassword

COPY target/Samsara-1.3.5.RELEASE.jar .
ENTRYPOINT ["java", "-jar", "/var/lib/jenkins/DevOps028/Samsara-1.3.5.RELEASE.jar"]

EXPOSE 9000