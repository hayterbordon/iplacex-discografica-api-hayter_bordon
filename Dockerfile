# ---------- Stage 1: Build ----------
FROM gradle:8.7.0-jdk23 AS builder
WORKDIR /app

# Copiar el proyecto al contenedor
COPY . .

# Construir el .jar (omitimos los tests para que compile más rápido)
RUN gradle clean build -x test

# ---------- Stage 2: Run ----------
FROM openjdk:23-jdk-slim
WORKDIR /app

# Copiar el artefacto compilado desde el builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Puerto donde corre Spring Boot
EXPOSE 8080

# Comando de ejecución
ENTRYPOINT ["java", "-jar", "app.jar"]
