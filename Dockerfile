FROM hub.c.163.com/library/java:8-alpine

ADD target/eureka-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8761

ENTRYPOINT ["java","-jar","/app.jar"]