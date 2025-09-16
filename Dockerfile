# -------- Stage 1: Build --------
FROM gradle:8.7.0-jdk21 AS builder
WORKDIR /app
COPY . .
RUN gradle clean build -x test

# -------- Stage 2: Run --------
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*-1.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
