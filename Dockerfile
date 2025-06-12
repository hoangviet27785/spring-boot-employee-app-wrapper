# Sử dụng hình ảnh Maven để build project
FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app

# Copy tất cả source code vào image
COPY . .

# Build project (tạo file .jar)
RUN mvn clean package -DskipTests

# Sử dụng JDK để chạy ứng dụng
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy file jar từ builder stage
COPY --from=builder /app/target/*.jar app.jar

# Mở cổng mặc định
EXPOSE 8080

# Lệnh chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
