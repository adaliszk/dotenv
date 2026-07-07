# System Configuration and Management

Just another personalized take on how to manage systems, configurations, and shared
tooling using Nix. The main purpose is to decouple system profiles into re-usable
flake packages that you can install or use.

## Prerequisites

- Install Nix in Daemon Mode: https://nixos.org/download
- Register the repository:
  ```bash
  nix registry add adaliszk github:adaliszk/system
  ```

## Setup

Main assumption for systems is that they are from scratch without GUI by default. The
goal with that is to leave the user-facing side to Nix, and keep the core system packages
focused around running the kernel and absolutely necessary services.

To kick off the global Nix configuration, run:

```bash
nix profile add adaliszk#essentials
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
- `adaliszk#hyprland`: core system-level engine for using Hyprland desktop environment

## System Packages with GUI

While it would be nice to have everything under Nix, there are some system-level workloads that
is way more struggle than it needs to be. For these, it is better to install a few packages locally:

```bash
pacman -Syu greetd hyprland

# Audio Systems
pacman -Syu pipewire pipewire-pulse pipewire-audio wireplumber
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Screen Sharing
pacman -Syu xdg-desktop-portal xdg-desktop-portal-hyprland rtkit
systemctl --user enable --now xdg-desktop-portal xdg-desktop-portal-hyprland
```

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

After installed the intended profiles, run the config update for setting up the user
home configurations:

```bash
system-update
```

This is also the command to be used for updating the system configs for updates.

## Contributions

While the main purpose is to share my own setup, feel free to use it as your own
template and any improvements are welcomed!
