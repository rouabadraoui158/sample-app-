#!/bin/bash

# Clean up existing containers and directory
docker stop samplerunning 2>/dev/null
docker rm samplerunning 2>/dev/null
rm -rf tempdir

# Create directory structure
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copy application files
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Create requirements file (only Flask needed)
echo "flask" > tempdir/requirements.txt

# Create Dockerfile
echo "FROM python:3.9-slim" > tempdir/Dockerfile
echo "WORKDIR /app" >> tempdir/Dockerfile
echo "COPY requirements.txt ." >> tempdir/Dockerfile
echo "RUN pip install --no-cache-dir --no-color --progress-bar off -r requirements.txt" >> tempdir/Dockerfile
echo "COPY static /app/static/" >> tempdir/Dockerfile
echo "COPY templates /app/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /app/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD [\"python\", \"sample_app.py\"]" >> tempdir/Dockerfile

# Build and run
cd tempdir
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
