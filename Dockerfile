# Use miniconda3 as the base image
FROM continuumio/miniconda3:4.10.3

# Set the working directory in the container to /src
WORKDIR /src

# Add contents into container
COPY . .

# Install necessary libraries and clean up in one RUN to reduce image size
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
    curl \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip --no-cache-dir

# Install mamba in the base environment
RUN conda install libarchive -n base -c conda-forge
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

# Set up .bashrc for auto activation of the environment
RUN echo "conda activate feems_env" > ~/.bashrc

# Install pip packages in the created environment
RUN /bin/bash -c "source activate feems_env && pip install --no-cache-dir scikit-sparse"

# Install feems from the GitHub repository
RUN /bin/bash -c "source activate feems_env && pip install --no-cache-dir git+https://github.com/NovembreLab/feems"

# Command to keep the container running
CMD ["tail", "-f", "/dev/null"]
