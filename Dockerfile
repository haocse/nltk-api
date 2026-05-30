FROM python:3.11-alpine
LABEL version="2.0"
LABEL description="Python 3 with NLTK and WordNet prepared (ARM64/AMD64)."

RUN apk update && apk add --no-cache ca-certificates gcc musl-dev

WORKDIR /app
COPY . /app

RUN pip install --upgrade pip && \
    pip install flask gunicorn nltk gevent

RUN python -W ignore -c "import nltk; nltk.download('wordnet'); nltk.download('punkt'); nltk.download('averaged_perceptron_tagger'); nltk.download('omw-1.4')"

ENV APP_PORT 5000

EXPOSE $APP_PORT

CMD python -m nltk_api
