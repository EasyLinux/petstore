FROM maven:3.5.2-jdk-7-alpine as build
  
WORKDIR /app
ADD spring-mvc.zip /app
RUN unzip spring-mvc.zip
WORKDIR /app/spring-mvc
RUN mvn package -Dmaven.test.skip=true

FROM jboss/wildfly:11.0.0.Final
COPY --from=build \
     /app/spring-mvc/target/swagger-spring-1.0.0.jar \
    ./wildfly/standalone/deployments/sprint.war

