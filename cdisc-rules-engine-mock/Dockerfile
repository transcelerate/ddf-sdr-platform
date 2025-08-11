FROM python:3.12-slim

RUN useradd -u 10001 -m appuser

WORKDIR /app
COPY core.py /app/core.py
RUN chmod +x /app/core.py

RUN mkdir -p /app/datasets /app/output && chown -R appuser:appuser /app

USER appuser
ENTRYPOINT ["python", "/app/core.py"]
