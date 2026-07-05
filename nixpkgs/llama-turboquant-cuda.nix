final: prev: {
  llama-turboquant-cuda = prev.callPackage ./scripts/llama-turboquant-atomic.nix {
    cmakeFlags = [ "-DGGML_CUDA=ON" ];
    extraNativeBuildInputs = [ prev.cudaPackages.cuda_nvcc ];
    pname = "llama-turboquant-cuda";
  };
}
