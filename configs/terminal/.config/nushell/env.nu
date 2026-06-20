# See https://www.nushell.sh/book/configuration.html

# Nix Profiles
$env.path ++= ["~/.nix-profile/bin"]
$env.path ++= ["/nix/var/nix/profiles/default/bin"]

# Jetbrains Toolbox
$env.path ++= ["~/.local/share/JetBrains/Toolbox/scripts"]

# Proto Tools
$env.path ++= ["~/.proto/shims", "~/.proto/bin"]

# Rendering Configs
$env.QT_QPA_PLATFORM = "wayland"
$env.QT_QUICK_BACKEND = "software"
$env.QSG_RHI_BACKEND = "vulkan"
