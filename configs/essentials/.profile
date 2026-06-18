# Nix Profiles
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH";
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

# JetBrains Toolbox
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# Proto Tools
export PATH="$PATH:$HOME/.proto/shims:$HOME/.proto/bin"

# Force Wayland for QT applications
export QT_QPA_PLATFORM=wayland
