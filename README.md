# Template-ML-gpu-dep

## Overview
**Template-ML-gpu-dep** provides a ready-to-use **Docker-based environment** for machine learning development with **NVIDIA GPU support** (PyTorch, TensorFlow, etc.).
It minimizes host dependency and ensures reproducibility across different setups.

- CUDA / cuDNN enabled GPU environment
- Easy startup via Docker Compose
- Supports both Jupyter Lab and CLI workflows
- Compatible with VS Code Dev Containers

---

## Requirements (Host)
- **Docker 24+** / **Docker Compose v2+**
- **NVIDIA Driver** installed on the host
- **NVIDIA Container Toolkit**

Verification:
```bash
nvidia-smi
docker run --rm --gpus all nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04 nvidia-smi
```

## Quickstart with Makefile
```make up```
