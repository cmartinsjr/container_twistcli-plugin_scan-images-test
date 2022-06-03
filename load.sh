#!/bin/bash
tar -czvf Dockerfile.tar.gz Dockerfile
docker load < Dockerfile.tar.gz