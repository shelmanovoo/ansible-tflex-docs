#!/bin/bash

echo "=== T-FLEX DOCs Quick Deployment ==="
echo

echo "Select deployment option:"
echo "1) Complete installation (site.yml)"
echo "2) Only prerequisites (prerequisites.yml)" 
echo "3) Only T-FLEX DOCs (install-docs.yml)"
echo
read -p "Enter choice (1-3): " choice

case $choice in
    1)
        playbook="playbooks/site.yml"
        echo "Running complete installation..."
        ;;
    2)
        playbook="playbooks/prerequisites.yml"
        echo "Running prerequisites installation..."
        ;;
    3)
        playbook="playbooks/install-docs.yml"
        echo "Running T-FLEX DOCs installation..."
        ;;
    *)
        echo "Invalid choice. Using complete installation."
        playbook="playbooks/site.yml"
        ;;
esac

echo
echo "Executing: ansible-playbook -i inventory/hosts.ini $playbook"
ansible-playbook -i inventory/hosts.ini "$playbook"

echo
echo "=== Deployment Complete ==="
