FROM python:3.10-slim

# 安裝 cron
RUN apt-get update && apt-get install -y cron

# 複製檔案
WORKDIR /app
COPY test.py /app/test.py
COPY crontab /etc/cron.d/cronjob

# 設定權限並註冊 crontab
RUN chmod 0644 /etc/cron.d/cronjob \
    && crontab /etc/cron.d/cronjob

# 執行 cron daemon 作為主進程
CMD ["cron", "-f"]
