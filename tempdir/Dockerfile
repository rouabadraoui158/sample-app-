FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --no-color --progress-bar off -r requirements.txt
COPY static /app/static/
COPY templates /app/templates/
COPY sample_app.py /app/
EXPOSE 5050
CMD ["python", "sample_app.py"]
