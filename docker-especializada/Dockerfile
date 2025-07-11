FROM openjdk:17
WORKDIR /wildfly
EXPOSE 8080
COPY ./wildfly .
RUN chmod -R 777 /wildfly
ENTRYPOINT ["/wildfly/bin/standalone.sh"]
CMD ["-c", "standalone-full.xml"]


# Nesse caso ele pega a pasta wildfly especialida já configurada e manda na imagem setando para executar direto o standalone com os argumentos.
# exemplo de build e run
# docker build -t aghu:1.0 .
# docker run -d -p 80:8080 aghu:1.0