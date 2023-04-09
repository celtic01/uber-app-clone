# First stage: build stage
FROM python:3.9.16-slim AS build

WORKDIR /build

COPY requirements.txt /build

RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt

COPY . /build/

RUN groupadd -r appusergroup \
&& useradd -g appusergroup appuser \
&& chown -R appuser:appusergroup /build \
&& chmod -R 755 /build

EXPOSE 5000

USER appuser

CMD [ "python", "app.py" ]
