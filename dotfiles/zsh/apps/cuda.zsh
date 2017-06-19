# Add CUDA commands to PATH
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}

# Add CUDA headers to library path.
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

