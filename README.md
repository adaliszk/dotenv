# System Configuration and Management

Just another personalized take on how to manage systems, configurations, and shared
tooling using Nix. The main purpose is to decouple system profiles into re-usable
flake packages that you can install or use.

## Prerequisites

- Install Nix in Daemon Mode: https://nixos.org/download
- Register the repository:
  ```bash
  sudo nix registry add adaliszk github:adaliszk/system
  ```

## Setup

Main assumption for systems is that they are from scratch without GUI by default. The
goal with that is to leave the user-facing side to Nix, and keep the core system packages
focused around running the kernel and absolutely necessary services.

To kick off the global Nix configuration, run:

```bash
sudo nix profile add adaliszk
```

After these essentials are installed, you can use `system-manager` to switch between
the available presets:

```bash
system-manager switch --sudo --flake <preset>
# Optionally, use my shortcut:
system-switch <preset>
```

Systems:

- `adaliszk#root`: empty configuration that only configures Nix itself
- `adaliszk#minimal`: minimum services and packages for protection and utilities
- `adaliszk#k3s`: kubernetes node using Rancher's K3s with network-based configuration
- `adaliszk#hyprland`: core system-level engine for using Hyprland desktop environment

## Customization

After the system is initialized, you have the choice to customize-it within your user
profile with additional tools and configurations:

```bash
nix profile add <profile>
```

Profiles:

- `adaliszk#essentials`: core tools and services that are used everywhere (default)
- `adaliszk#hyprland`: customized Hyprland using Nix and Stow
- `adaliszk#terminal`: terminal-based "desktop" environment using Nix and Stow
- `adaliszk#browser`: web browser with its plugins and themes pre-installed
- `adaliszk#messaging`: various messaging apps for keeping connections up
- `adaliszk#kubeadmin`: tools for managing kubernetes clusters
- `adaliszk#webdev`: web-based development editors, plugins, and tools
- `adaliszk#phpdev`: php-based development editors, plugins, and tools
- `adaliszk#minecraft`: modded Minecraft gaming and mod development tools
- `adaliszk#creator`: content creation tools for YouTube and other socials
- `adaliszk#agentdev`: wrap LLM-based development with fine-tune controls
- `adaliszk#neovim`: customized neovim using Nix and Stow

## Contributions

While the main purpose is to share my own setup, feel free to use it as your own
template and any improvements are welcomed!
