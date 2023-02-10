FROM python:3.7-alpine
ENV PYTHONUNBUFFERED=1
RUN apk add -u gcc musl-dev
RUN mkdir /app
WORKDIR /app
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN pip install pytz
RUN pip install --no-deps ruamel.yaml -r requirements.txt
COPY . .