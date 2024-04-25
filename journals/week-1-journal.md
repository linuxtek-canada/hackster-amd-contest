# Week 1 Journal - April 19-20, 2024

## Summary

April 19, 2024:
* Set up access to AMD Accelerator Cloud.
* Joined Webinar to learn how to use AAC and asked questions.
* Created a script to start installing prerequisites for LocalAI inside the available Ubuntu container.
* Troubleshooting compile issues with gRPC and LocalAI due to dependencies.
* Troubleshooting build performance due to limited CPU core usage.
* Tested Mixtral-Instruct for LocalAI LLM.
* Started Documentation
* See amd-accelerator-cloud [README.md](../amd-accelerator-cloud/README.md) for more details.
* Time Spent: 8 hours.

April 20, 2024:
* Tweaked script to better automate.
* Completed documentation for AMD Accelerator Cloud usage.
* Completed project documentation and pushed first draft to Github.
* Time Spent: 4 hours.

April 21, 2024:
* Testing tweaks and improvements to AMD Accelerator Cloud OpenAI installation script.
* Tested SSH tunnel to allow access to LocalAI "locally" on my workstation via SSH local port forwarding.
* Time Spent: 2 hours.

April 22, 2024:
* Tested upgrades to Ubuntu image on AMD Accelerator Cloud.
* Determined I am not able to upgrade Linux Kernel or ROCm drivers directly within the container.
* Requested in Discord #☁amd-mi210 channel to have ability to load customized Docker images.
* Requested in Discord #☁amd-mi210 channel to have an updated Ubuntu image built and made available with Linux Kernel 6.5 and ROCm 6.1.0.
* This was supported by other members, as latest PyTorch 2.3 RC does not work with ROCm 5.7, and has performance improvements.
* Time Spent: 2 hours.

April 23, 2024:
* Attempted to run LocalAI using my personal Radeon RX 7900XT GPU.  
* Used the "All-in-One" AMD GPU image [listed here](https://localai.io/docs/reference/aio-images/).
* Built docker-compose file to configure LocalAI.
* Upgraded workstation to Fedora 40 with Linux Kernel 6.8.7-300.fc40.x86_64, and ROCm 6.0.2.
* Troubleshooting issues loading LLM - probably [this issue](https://github.com/mudler/LocalAI/issues/800)
* Time Spent: 4 hours.

April 24, 2024:
* Troubleshooting issues loading LLM to test.
* Determined problem was due to the AMD GPU and CPU both showing up as valid devices for offloading. 
* Tested excluding CPU by specifying /dev/dri/renderD128, and also setting `HIP_VISIBLE_DEVICES=0`.
* Set up cached directory for storing model downloads (excluded from Github).
* Successfully ran LocalAI AIO tests on AMD RX 7900XT GPU.