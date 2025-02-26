# Dotfiles and Package Management

Just another personalized dotfiles and environment confguration repository.
Generally speaking, the setup here are for web-based software engineers
who use Kubernetes and Docker regurarly. Main IDE is the various JetBrains
editors, while in the terminal having neovim for quick edits.

## Pre-requities

While the profiles would install amost everything, there are a few system
packages that you do need to supply yourself:

- Nix: https://nixos.org/download
- Stow: https://www.gnu.org/software/stow/#download

## Usage

While the nix profiles can use github directly, the configuration files
needed to be cloned:

```bash
git clone https://github.com/adaliszk/dotenv
```

To install the configuration files, use:

```bash
cd dotenv && stow configs
```

After that you can install the various profiles:

```bash
nix profile install github:adaliszk/dotenv#essentials
```

Note: If you want to use the local path, you can use: `./dotenv#essentials`

## Profiles

- `essentials`: shell utilities and management tools
- `devtools`: IDEs and their dependencies using a GUI
- `applications`: everyday GUI applications

## Contributions

While the main purpose is to share my own setup, if you use it and want to
improve it, then I am more than happy to discuss and accept pull requests.
