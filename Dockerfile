FROM python:3.10-slim

# 安裝 cron
RUN apt-get update && apt-get install -y cron && apt-get clean

WORKDIR /app
COPY test.py /app/test.py
COPY crontab /etc/cron.d/cronjob

RUN chmod 0644 /etc/cron.d/cronjob && crontab /etc/cron.d/cronjob
RUN touch /var/log/cron.log

CMD ["cron", "-f", "-L", "8"]
