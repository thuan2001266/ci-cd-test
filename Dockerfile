# Stage 1: Build stage
FROM openjdk:17-jdk-slim AS builder

WORKDIR /app

COPY . .

RUN ./mvnw package

# Stage 2: Production stage
FROM openjdk:17-jdk-slim AS production

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
