FROM openjdk:8
COPY ./app/ /usr/local/app/workspace/
WORKDIR /usr/local/app/workspace/
ENTRYPOINT ["java",\
"-jar",\
"-Dspring.config.location=/usr/local/app/conf/application.properties",\
"/usr/local/app/workspace/service-core.jar"]
EXPOSE 9211