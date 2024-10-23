# !/bin/bash

# Branch compare script

if [ $# -eq 1 ]; then
    base_commit="HEAD"
    target_commit="$1"
elif [ $# -eq 2 ]; then
    base_commit="$1"
    target_commit="$2"
else
    echo "Error: Se requieren uno o dos parámetros: $0 [<commit_base>] <commit_target>. Por defecto, con un solo parámetro se usa HEAD como commit base"
    exit 1
fi

# Imprime información de una lista de commits pasados como parámetros. Si no hay commits no imprime nada
format='%C(yellow)%h %C(green)%cr %C(cyan)%d %C(reset)%s %C(red)(%an)'
show_commits() {
test -n "$1" && echo "$1" | xargs git show -s --format="${format}" || true
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'


listado=$(git rev-list --boundary --left-right "$base_commit"..."$target_commit")

#Commits comunes: deben ordenarse por fecha primero
comunes=$(echo "$listado" | grep ^-| sed 's/^-\(.*\)$/\1/' | xargs git show -s --format="%at %H" | sort -r | cut -d ' ' -f2)

# Último commit común:

printf "\n${BLUE}%1s\n\n" "Último commit común:"
show_commits $(echo $comunes|head -1)
echo

# Commits exclusivos de la rama 'base':
commits_base=$(echo "$listado" | grep ^\< | sed 's/^<\(.*\)$/\1/')

# Commits exclusivos de la rama 'target'
commits_target=$(echo "$listado" | grep ^\> | sed 's/^>\(.*\)$/\1/')

# Número de commits exclusivos en cada rama
printf "\n${GREEN}%1s" "Número de commits SOLO en $base_commit: $(test -n "$commits_base" && echo "$commits_base" | wc -l || echo 0)"
printf "\n${RED}%1s\n\n" "Número de commits SOLO en $target_commit: $(test -n "$commits_target" && echo "$commits_target" | wc -l || echo 0)"


printf "\n${BLUE}%1s\n" "En ${base_commit}:"
show_commits "$commits_base"

printf "\n${BLUE}%1s\n" "En ${target_commit}:"
show_commits "$commits_target"

printf "\n${BLUE}%1s\n" "Ancestros comunes:"
show_commits "$comunes"
