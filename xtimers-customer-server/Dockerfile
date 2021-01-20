FROM adoptopenjdk/openjdk11:alpine
COPY /target/xtimers-customer-server-1.0-SNAPSHOT-exec.jar /tmp/xtimer-customer.jar
EXPOSE 8080 3306
ENTRYPOINT ["java","-jar","-Ddb=mysql","/tmp/xtimer-customer.jar"]