FROM alpine:latest

RUN apk update && apk add python py-openssl

ADD https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-120.0.0-linux-x86_64.tar.gz /opt/google-cloud-sdk.tar.gz
RUN tar -xzf /opt/google-cloud-sdk.tar.gz -C /opt && \
  /opt/google-cloud-sdk/install.sh --quiet --path-update=true --command-completion=true \
    --usage-reporting=true --additional-components=kubectl
ENV PATH /opt/google-cloud-sdk/bin:$PATH

COPY docker-entrypoint.sh /opt/google-cloud-sdk/docker-entrypoint.sh
ENTRYPOINT ["/opt/google-cloud-sdk/docker-entrypoint.sh"]
CMD ["gcloud"]