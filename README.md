# feems in docker

This is a fork of [feems](https://github.com/NovembreLab/feems) made to work in Docker on any envrionement with minimal setup and configuration.

## Table of contents

- [What to expect](#what-to-expect)
- [Folder structure](#folder-structure)
- [Run it](#run-it)
  - [Prerequisites](#prerequisites)
  - [Makefile](#makefile)

# What to expect

**F**ast **E**stimation of **E**ffective **M**igration **S**urfaces (`feems`) is a python package
implementing a statistical method for inferring and visualizing gene-flow in
spatial population genetic data.<br/>

The `feems` method and software was developed by Joe Marcus and Wooseok Ha and
advised by Rina Foygel Barber and John Novembre. We also used code from Benjamin M. Peter
to help construct the spatial graphs.

For details on the method see our [pre-print](https://www.biorxiv.org/content/10.1101/2020.08.07.242214v1). Note that `feems` is in review so the method could be subject to change.

# Folder structure

Add stuff about the folders

# Run it

## Prerequisites

- [Docker and docker-compose](https://docs.docker.com/get-docker/)
- Makefile

> Note: for Windows users make can be install with [choco](https://community.chocolatey.org/packages/make)

## Makefile

The Makefile allows for an easier experience to get things running.

To run the project:

```sh
make run
```
> This will start the docker container for you

To help with debugging:

```sh
make shell
```
