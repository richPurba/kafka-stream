FROM openjdk:8

# for training purposed configure uid to be 1024 for dshdemo1 or 1025 for
# dshdemo2
ENV id 1071
ADD get_signed_certificate.sh /get_signed_certificate.sh
ADD docker-entrypoint.sh /docker-entrypoint.sh

# i changed the gid (on RUN useradd) to hod from dshdemo. Is this correct?
RUN groupadd --gid $id hod
RUN useradd --no-create-home --uid $id --gid $id hod

RUN mkdir -p /usr/share/kafka-client/conf
ADD target/streams.examples-0.1-jar-with-dependencies.jar /usr/share/kafka-client/streams.examples.jar

RUN chown -R $id:$id /usr/share/kafka-client \
    && chmod -R o-rwx /usr/share/kafka-client
USER $id

ENTRYPOINT [ "/docker-entrypoint.sh" ]