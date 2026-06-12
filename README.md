# Dotfiles and Package Management

Just another personalized dotfiles and environment configuration repository.
Generally speaking, the setup here are for web-based software engineers
who use Kubernetes and Docker regularly. Main IDE is the various JetBrains
editors, while in the terminal having neovim for quick edits.

## Prerequisites

While the profiles would install almost everything, there are a few system
packages that you do need to supply yourself:

- Nix: https://nixos.org/download

## Usage

While the nix profiles can use github directly, the configuration files
needed to be cloned:

```bash
git clone https://github.com/adaliszk/system System
```

To install the configuration files, use:

```bash
cd dotenv && stow configs
```

After that you can install the various profiles:

```bash
nix profile install github:adaliszk/system#essentials
```

## Contributions

While the main purpose is to share my own setup, if you use it and want to
improve it, then I am more than happy to discuss and accept pull requests.
