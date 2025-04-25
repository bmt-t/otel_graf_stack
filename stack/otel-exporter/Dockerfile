FROM python:3.11-slim

RUN apt-get update && apt-get install -y zabbix-sender

WORKDIR /app
COPY otel_zabbix_exporter.py /app/
RUN pip install flask

EXPOSE 5000
CMD ["python", "otel_zabbix_exporter.py"]