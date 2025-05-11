FROM python:3.10-slim

# 安裝 cron 和必要工具
RUN apt-get update && apt-get install -y cron && apt-get clean

# 建立工作目錄
WORKDIR /app

# 複製檔案
COPY test.py /app/test.py
COPY crontab /etc/cron.d/cronjob

# 設定權限與註冊 crontab
RUN chmod 0644 /etc/cron.d/cronjob \
    && crontab /etc/cron.d/cronjob

# 啟用 log 輸出位置（避免容器沒輸出）
RUN touch /var/log/cron.log

# 設定 cron 為前景執行並印出 log
CMD ["cron", "-f", "-L", "8"]
