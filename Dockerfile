FROM python:3.10-slim

# 安裝 cron
RUN apt-get update && apt-get install -y cron && apt-get clean

# 建立工作目錄
WORKDIR /app

# 複製 Python 腳本和 crontab 設定
COPY test.py /app/test.py
COPY crontab /etc/cron.d/cronjob

# 設定權限與註冊 crontab
RUN chmod 0644 /etc/cron.d/cronjob \
    && crontab /etc/cron.d/cronjob

# 避免無輸出，建立 cron log 檔
RUN touch /var/log/cron.log

# 執行 cron 為前景行程，讓 Zeabur 保持容器運行
CMD ["cron", "-f", "-L", "8"]
