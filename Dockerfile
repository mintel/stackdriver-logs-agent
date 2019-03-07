from debian:9-slim

LABEL org.label-schema.vcs-url="https://github.com/mintel/stackdriver-logs-agent" \
      org.label-schema.vendor=mintel \
      org.label-schema.name=stackdriver-logs-agent

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl gnupg2 && \
    echo "deb http://packages.cloud.google.com/apt google-cloud-logging-wheezy main" | tee /etc/apt/sources.list.d/google-cloud-monitoring.list && \
    curl --silent https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-fluentd

COPY run-agent.sh /usr/bin/run-agent.sh
COPY google-fluentd.conf /etc/google-fluentd/google-fluentd.conf

CMD ["run-agent.sh"]

