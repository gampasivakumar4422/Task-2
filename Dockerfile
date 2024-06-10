FROM tomcat:latest

LABEL maintainer="SivaKumar"

COPY ./target/SivaKumar-1.0.war /usr/local/tomcat/webapps/Siva.war

EXPOSE 8080
