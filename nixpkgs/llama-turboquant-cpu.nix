final: prev: {
  llama-turboquant-cpu = prev.callPackage ./scripts/llama-turboquant-atomic.nix {
    pname = "llama-turboquant-cpu";
  };
}
