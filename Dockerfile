# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y \
    build-essential \
    libopenblas-dev \
    liblapack-dev \
    wget \
    unzip \
    software-properties-common \
    libgdal-dev \
    libblas-dev \
    libatlas-base-dev \
    libsuitesparse-dev \
    libgsl-dev \
    git \
    libproj-dev proj-data proj-bin \
    libgeos-dev \
    libffi-dev

RUN pip install GDAL==$(gdal-config --version)

# Install Python dependencies
RUN pip install -r requirements.txt

# Install feems from the GitHub repository
RUN pip install git+https://github.com/NovembreLab/feems

# Entry point to keep the container running
ENTRYPOINT ["tail", "-f", "/dev/null"]
