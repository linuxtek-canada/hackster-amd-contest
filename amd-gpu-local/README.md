ROCm Supported GPUs:
https://rocm.docs.amd.com/projects/install-on-linux/en/docs-6.0.0/reference/system-requirements.html
Radeon RT 7900XT = NAVI31 = gfx1100

ROCm Subreddit:
https://old.reddit.com/r/ROCm


Install ROCm Prerequisites on Fedora 39:
https://medium.com/@anvesh.jhuboo/rocm-pytorch-on-fedora-51224563e5be

Fedora:  https://fedoraproject.org/wiki/SIGs/HC

sudo dnf config-manager --add-repo=https://repo.radeon.com/amdgpu/6.1/rhel/9.3/main/x86_64/
sudo dnf config-manager --add-repo=https://repo.radeon.com/rocm/yum/6.1/main/


```
sudo usermod -a -G render,video $LOGNAME

sudo dnf install rocm-opencl rocm-clinfo rocm-hip rocm-hip-devel
sudo dnf install hipcc rocblas-devel hipblas-devel git cmake g++ lld clang-tools-extra llvm

rocm-clinfo

sudo usermod -aG render $LOGNAME && sudo usermod -aG video $LOGNAME


https://www.techpowerup.com/gpu-specs/amd-navi-31.g998


Docker-Compose: 
https://localai.io/features/gpu-acceleration/


Install ROCm Prerequisites on Fedora 39:
https://medium.com/@anvesh.jhuboo/rocm-pytorch-on-fedora-51224563e5be


```
sudo tee /etc/yum.repos.d/amdgpu.repo <<EOF
[amdgpu]
name=amdgpu
baseurl=https://repo.radeon.com/amdgpu/6.1/rhel/9.3/main/x86_64/
enabled=1
priority=50
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF
sudo yum clean all
```

```
sudo tee --append /etc/yum.repos.d/rocm.repo <<EOF
[ROCm-6.1]
name=ROCm6.1
baseurl=https://repo.radeon.com/rocm/yum/6.1/main/
enabled=1
priority=50
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF
sudo yum clean all
```

sudo yum install amdgpu-dkms
sudo yum install rocm

sudo dnf install amdgpu-dkms rocm rocm-opencl rocm-clinfo rocm-hip rocm-hip-devel



curl http://localhost:8080/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{ "model": "gpt-4", "messages": [{"role": "user", "content": "How are you doing?", "temperature": 0.1}] }'

Fedora 40
ROCM 6.0 Notes:
https://github.com/nktice/AMD-AI/blob/main/ROCm6.0.md


https://github.com/mudler/LocalAI/issues/1592e

Midori's Website Easy Model Setup:  https://io.midori-ai.xyz/howtos/by_hand/easy-model/

VS Code Shortcuts for Linux: https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf

===================

ROCM Install  https://rocm.docs.amd.com/projects/install-on-linux/en/docs-6.0.2/how-to/native-install/post-install.html
6.0.2 on Fedora 40

Post Install

```
sudo tee --append /etc/ld.so.conf.d/rocm.conf <<EOF
/opt/rocm/lib
/opt/rocm/lib64
EOF
sudo ldconfig
```
Usually you can force your app to only use the GPU with HIP_VISIBLE_DEVICES=0 or CUDA_VISIBLE_DEVICES=0 with 0 being the device ID of the Radeon GPU.
