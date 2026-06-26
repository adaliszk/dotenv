set -euo pipefail
declare -A REPOS=(
    [caveman]="https://github.com/JuliusBrussee/caveman main"
    [ponytail]="https://github.com/DietrichGebert/ponytail main"
)

mkdir -p vendor
for name in "''${!REPOS[@]}"; do
    read -r url branch <<<"''${REPOS[$name]}"
    path="vendor/$name"
    if [ -d "$path" ]; then
        git submodule update --remote "$path"
        git commit -m "chore(skills): update $name" "$path" || true
    else
        git submodule add -b "$branch" "$url" "$path"
        git commit -m "feat(skills): add $name" .gitmodules "$path"
    fi
done

mkdir -p skills
find skills -maxdepth 1 -type l -delete
for d in vendor/*/skills/*/; do
    [ -d "$d" ] || continue
    ln -sfn "../$d" "skills/$(basename "$d")"
done
