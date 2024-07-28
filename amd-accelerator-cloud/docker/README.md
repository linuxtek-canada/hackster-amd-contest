# Docker Containers on AMD Accelerator Cloud

## Introduction

In July, AMD added the ability to launch custom Docker containers on AMD Accelerator Cloud. This feature is currently in beta, but we were granted access to test it.

This allowed running custom images, rather than having to use the stock Ubuntu ROCm image and installing all of the needed software inside the container.

The amount of time a workload could run on AMD Accelerator Cloud was also increased from 4 hours to 8 hours.

## Running Custom Images

When starting a workload, we can now choose a **Docker Container** for using our own Docker image:

![aac-docker1](../../media-assets/aac-docker1.png)

* We can enable SSH for Ubuntu and CentOS based images.

* From Docker Hub, the latest "All In One" LocalAI image for AMD GPUs is:  `localai/localai:latest-aio-gpu-hipblas`.  For an image without pre-installed models there is `localai/localai:latest-gpu-hipblas`.

* After choosing the parameters and running the workload, it takes about [10 minutes](../../media-assets/aac-loading-hipblas.png) to fully download and launch the container.  This is because the full image is quite large:

![dockerhub-localai-hipblas](../../media-assets/dockerhub-localai-hipblas.png)

* Once the image is downloaded and ready, we can SSH into the container (and also set up local port forwarding):

```
ssh -L [LOCAL_IP:]LOCAL_PORT:DESTINATION:DESTINATION_PORT [USER@]SSH_SERVER

ssh aac@aac1.amd.com -p 7010 -L 8080:127.0.0.1:8080
```