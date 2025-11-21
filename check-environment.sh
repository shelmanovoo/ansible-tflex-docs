#!/bin/bash

echo "=== T-FLEX DOCs Environment Check ==="
echo

# Check commands
echo "1. Required Commands:"
commands=("git" "ansible" "ansible-galaxy")
for cmd in "${commands[@]}"; do
    if command -v $cmd >/dev/null 2>&1; then
        echo "✓ $cmd: $(which $cmd)"
    else
        echo "✗ $cmd: NOT FOUND"
    fi
done

echo
echo "2. Ansible Collections:"
if ansible-galaxy collection list ansible.windows >/dev/null 2>&1; then
    echo "✓ ansible.windows: installed"
else
    echo "✗ ansible.windows: not installed"
fi

if ansible-galaxy collection list chocolatey.chocolatey >/dev/null 2>&1; then
    echo "✓ chocolatey.chocolatey: installed"
else
    echo "✗ chocolatey.chocolatey: not installed"
fi

echo
echo "3. Project Structure:"
important_files=(
    "inventory/hosts.ini"
    "group_vars/all.yml" 
    "playbooks/site.yml"
    "roles/docs_prerequisites/tasks/main.yml"
    "roles/docs_install/tasks/main.yml"
    "roles/docs_firewall/tasks/main.yml"
)

for file in "${important_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file: missing"
    fi
done

echo
echo "=== Check Complete ==="
