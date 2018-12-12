FROM alpine:3.8 as build
RUN apk add ca-certificates

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY docker-credential-ecr-login /

ENTRYPOINT ["/docker-credential-ecr-login"]
