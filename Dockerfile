FROM openjdk:8

ENV JHIPSTER_SLEEP 0

# add source
ADD . /code/
RUN chmod -R 755 /code
# package the application and delete all lib
RUN echo '{ "allow_root": true }' > /root/.bowerrc && \
    cd /code/ && \
    ./gradlew -Pdev -DskipTests bootRepackage && \
    ls -lah /code/build/libs && \
    mv /code/build/libs/*.jar /app.jar && \
    rm -Rf /code /root/.npm/ /tmp && \
    rm -Rf /root/.m2/

RUN sh -c 'touch /app.jar'
VOLUME /tmp
EXPOSE 8080
CMD echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
    sleep ${JHIPSTER_SLEEP} && \
    java -Djava.security.egd=file:/dev/./urandom -jar /app.jar
