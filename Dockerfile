# Use an official Ubuntu 20.04 as a parent image
FROM ubuntu:20.04

# Avoid timezone prompt during the installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory in the container to /feems
WORKDIR /feems

# Add contents into container
COPY . .

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y \
    build-essential \
    libopenblas-dev \
    liblapack-dev \
    wget \
    unzip \
    software-properties-common \
    libgdal-dev \
    libxerces-c-dev \
    libpoppler-dev \
    libblas-dev \
    libatlas-base-dev \
    libsuitesparse-dev \
    libgsl-dev \
    git \
    libproj-dev proj-data proj-bin \
    libgeos-dev \
    libffi-dev \
    python3-pip \
    curl \
    libgomp1

RUN pip3 install --upgrade pip

# Install conda
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh && \
    bash Miniforge3-Linux-aarch64.sh -b -p /opt/conda && \
    rm Miniforge3-Linux-aarch64.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:${PATH}"

# Install mamba in the base environment
RUN conda install -c conda-forge mamba

# Create a new conda environment and install packages
RUN mamba create -y -n feems_env -c conda-forge -c bioconda -c defaults \
    numpy=1.22.3 \
    pyproj=2.6.1.post1 \
    networkx=2.4.0 \
    shapely=1.7.1 \
    Fiona=1.8.13.post1 \
    pep8=1.7.1 \
    flake8=3.8.3 \
    click=7.1.2 \
    setuptools \
    statsmodels=0.12.2 \
    PyYAML=5.4.1 \
    xlrd=2.0.1 \
    openpyxl=3.0.7 \
    suitesparse=5.7.2 \
    cartopy=0.18.0 \
    matplotlib=3.4.3
    
# Set up .bashrc for auto activationof the environment
RUN echo "source activate feems_env" > ~/.bashrc

# Install pip packages in the created environment
RUN /bin/bash -c "source activate feems_env && pip install scikit-sparse"

# Install feems from the GitHub repository
RUN /bin/bash -c "source activate feems_env && pip install git+https://github.com/NovembreLab/feems"

# Entry point to keep the container running
ENTRYPOINT ["tail", "-f", "/dev/null"]
