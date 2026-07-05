final: prev: {
  llama-turboquant-rocm = prev.callPackage ./scripts/llama-turboquant-atomic.nix {
    cmakeFlags = [
      "-DGGML_HIP=ON"
      "-DAMDGPU_TARGETS=gfx1150"
    ];
    extraNativeBuildInputs = [ prev.rocmPackages.hipcc ];
    pname = "llama-turboquant-rocm";
  };
}
