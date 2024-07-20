###
## Build OCI for the Eventbus prototype
#
FROM gcr.io/distroless/java21:latest

ADD target/artifacts/eventbus.jar /eventbus.jar

CMD [ "/eventbus.jar" ]
