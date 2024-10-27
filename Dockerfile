# Step 1: Folosim Maven pentru a construi fișierul JAR
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Folosim o imagine JRE pentru a rula aplicația
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/gateway-api-0.0.1-SNAPSHOT.jar app.jar

# Expunem portul specificat pentru Gateway
EXPOSE 8765

# Comanda pentru a rula aplicația Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]