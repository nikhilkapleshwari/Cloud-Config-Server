#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY app/src /home/app/src
COPY app/pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/CloudConfigServer-0.0.1-SNAPSHOT.jar /usr/local/lib/CloudConfigServer-0.0.1-SNAPSHOT.jar
#EXPOSE 8080
ENTRYPOINT ["java","-Dspring.config.location=/etc/config/application.yaml","-jar","/usr/local/lib/CloudConfigServer-0.0.1-SNAPSHOT.jar"]
