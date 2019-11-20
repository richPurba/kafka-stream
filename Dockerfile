FROM maven:3.3-jdk-8
COPY . /usr/src/kafkaclient/
WORKDIR /usr/src/kafkaclient/


# for training purposed configure uid to be 1024 for dshdemo1 or 1025 for
# dshdemo2
ENV id 1071
ADD get_signed_certificate.sh /get_signed_certificate.sh
ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN groupadd --gid $id hod
RUN useradd --no-create-home --uid $id --gid $id hod

RUN mkdir -p /usr/share/kafka-client/conf

USER $id

ENTRYPOINT [ "mvn", "exec:java", "-Dexec.mainClass=myapps.WordCount" ]
