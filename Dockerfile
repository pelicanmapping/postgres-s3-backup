FROM ubuntu:16.04

# Update apt
RUN apt-get update && \
    apt-get -y install \
    postgresql-client-9.5 \
    python-pip \
    cron \
    && rm -rf /var/lib/apt/lists/*

RUN pip install awscli

COPY backup /etc/cron.daily/backup
RUN chmod 755 /etc/cron.daily/backup
RUN chown root:root /etc/cron.daily/backup

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log