FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app

COPY api/gateway/gateway-service/pom.xml ./api/gateway/gateway-service/pom.xml
COPY api/gateway/gateway-service/src     ./api/gateway/gateway-service/src
RUN cd api/gateway/gateway-service && mvn clean package -DskipTests -q

FROM eclipse-temurin:25-jre
WORKDIR /app
COPY --from=build /app/api/gateway/gateway-service/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
