{
  pname,
  stdenv,
  fetchFromGitHub,
  cmake,
  cmakeFlags ? [ ],
  extraNativeBuildInputs ? [ ],
}:
stdenv.mkDerivation {
  version = "2e81dc5";
  src = fetchFromGitHub {
    owner = "AtomicBot-ai";
    repo = "atomic-llama-cpp-turboquant";
    rev = "2e81dc5";
    hash = "sha256-8uFn74hPH3P4drSAfBk4DKuf53+1BZXYUP+AhgPEQgY=";
  };
  nativeBuildInputs = [ cmake ] ++ extraNativeBuildInputs;
  inherit cmakeFlags;
  inherit pname;
}
