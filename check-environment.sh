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
    echo "✗ ansible.windows: not installed - run: ansible-galaxy collection install ansible.windows"
fi

if ansible-galaxy collection list chocolatey.chocolatey >/dev/null 2>&1; then
    echo "✓ chocolatey.chocolatey: installed"
else
    echo "✗ chocolatey.chocolatey: not installed - run: ansible-galaxy collection install chocolatey.chocolatey"
fi

echo
echo "3. Project Files:"
important_files=(
    "inventory/hosts.ini"
    "group_vars/all.yml" 
    "playbooks/deploy-tflex.yml"
    "playbooks/test-connection.yml"
    "ansible.cfg"
)

for file in "${important_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file: missing"
    fi
done

echo
echo "4. Ansible Configuration Test:"
if ansible-playbook -i inventory/hosts.ini playbooks/test-connection.yml --syntax-check >/dev/null 2>&1; then
    echo "✓ Ansible syntax: OK"
else
    echo "✗ Ansible syntax: ERROR"
fi

echo
echo "=== Check Complete ==="
echo "If all checks pass, run: ./quick-deploy.sh"
