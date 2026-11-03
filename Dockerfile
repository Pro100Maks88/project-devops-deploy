
FROM node:20-alpine AS frontend
WORKDIR /frontend
COPY frontend/package.json frontend/package-lock.json* ./
RUN npm ci
COPY frontend/ ./
RUN npm run build


FROM eclipse-temurin:27-jdk AS builder
WORKDIR /app
COPY gradlew settings.gradle.kts build.gradle.kts ./
COPY gradle ./gradle
COPY src ./src
COPY --from=frontend /frontend/dist ./src/main/resources/static
RUN chmod +x gradlew && ./gradlew test bootJar --no-daemon

FROM eclipse-temurin:27-jre
WORKDIR /app
COPY --from=builder /app/build/libs/project-devops-deploy-0.0.1-SNAPSHOT.jar /app/app.jar
ENV SPRING_PROFILES_ACTIVE=dev
EXPOSE 8080 9090
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]