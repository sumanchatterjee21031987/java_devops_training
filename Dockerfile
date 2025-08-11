# Use Maven to build the application
FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app
COPY . /app
RUN mvn clean package -DskipTests

# Use a lightweight Java 17 runtime to run the application
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/spring-boot-jpa-postgresql-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
