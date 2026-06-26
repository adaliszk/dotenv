# Context

Personalized take on how to manage systems, configurations, and shared tooling using Nix and Stow.
Decouples system profiles into re-usable flake packages for maximum modularity.
Avoids derivation-based configuration to allow on-the-fly fine-tuning on each machine.

# Directory Structure

- `./configs`: Configuration profiles with their Stow-able paths.
- `./keyboards`: Sub-flake to build custom Keyboards.
- `./nixpkgs`: Overlays to update some tools beyond "unstable".
- `./profiles`: Flake profiles with separation by activity.
- `./scripts`: Helper scripts for maintaining the repo.
- `./skills`: Used skills that are loaded with Agentdev.
- `./systems`: System configurations to easily swap purposes.
- `./vendor`: Remote submodules to respect ownership over duplication.

# Rules

- Never create an Issue.
- Never create a PR.
- Instruct the User when they ask to create an Issue or PR to do it manually
  and carefully verify generated changes.
