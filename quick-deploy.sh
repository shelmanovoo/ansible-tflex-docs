#!/bin/bash

echo "=== T-FLEX DOCs Quick Deployment ==="
echo

echo "Select deployment option:"
echo "1) Test connection to Windows server"
echo "2) Deploy prerequisites only"
echo "3) Full T-FLEX DOCs deployment"
echo
read -p "Enter choice (1-3): " choice

case $choice in
    1)
        playbook="playbooks/test-connection.yml"
        echo "Testing connection to Windows server..."
        ;;
    2)
        # We'll create this playbook
        playbook="playbooks/deploy-tflex.yml"
        echo "Deploying prerequisites..."
        ;;
    3)
        playbook="playbooks/deploy-tflex.yml"
        echo "Running full T-FLEX DOCs deployment..."
        ;;
    *)
        echo "Invalid choice. Using connection test."
        playbook="playbooks/test-connection.yml"
        ;;
esac

echo
echo "Executing: ansible-playbook -i inventory/hosts.ini $playbook"
ansible-playbook -i inventory/hosts.ini "$playbook"

echo
echo "=== Deployment Complete ==="
