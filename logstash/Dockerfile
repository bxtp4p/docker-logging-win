FROM docker.elastic.co/logstash/logstash:6.1.1

COPY logstash.conf /etc/logstash.conf

ENTRYPOINT [ "logstash" ]
CMD ["-f", "/etc/logstash.conf"]