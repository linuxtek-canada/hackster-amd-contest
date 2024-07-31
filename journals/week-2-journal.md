# Week 2 Journal - April 28 - May 4, 2024

## Summary

May 3, 2024:
* Working with LocalAI developers to test a new hipblas build that includes fixes I need. Provided testing and feedback on [this pull request](https://github.com/mudler/LocalAI/pull/2196)
* From working with [cryptk](https://github.com/cryptk), we found a problem in the ROCm installation sequence for LocalAI, where the build succeeds, but running LocalAI fails with the following error:

```
localai-1  | CPU:    AVX    found OK
localai-1  | CPU:    AVX2   found OK
localai-1  | CPU:    AVX512 found OK
localai-1  | @@@@@
localai-1  | ./local-ai: error while loading shared libraries: libhipblas.so.2: cannot open shared object file: No such file or directory
localai-1 exited with code 127
```

This is due to the ROCm packages do not run ldconfig after installing via a trigger, which is contrary to [Debian standard package creation policy](https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#ldconfig).  We added a manual step to run ldconfig as part of the LocalAI Docker image build process to compensate.

* Logged [this issue](https://github.com/ROCm/ROCm/issues/3081) with ROCm to correct this, along with explanations and testing illustrating the issue.
* Time Spent: 12 hours.