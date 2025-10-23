FROM python:3.9.24-alpine3.22
USER root
WORKDIR /opt/app
ARG LAB_LOGIN LAB_TOKEN
STOPSIGNAL SIGTERM
LABEL org.lab.login=matveykov org.lab.token=e10f26c4aa693d8c1aa9b12444ad4ac6

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

ENTRYPOINT ["python", "-m", "app.app"]
HEALTHCHECK --interval=15s CMD wget --spider 0.0.0.0:8000/health || exit 1

USER 1000