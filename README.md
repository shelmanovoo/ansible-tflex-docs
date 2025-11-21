# T-FLEX DOCs Ansible Project

Automated installation of T-FLEX DOCs Server 17.

## Quick Start

1. Update inventory/hosts.ini with your server details
2. Run: ansible-playbook -i inventory/hosts.ini playbooks/site.yml

## Project Structure

- inventory/hosts.ini - Server configuration
- group_vars/all.yml - Global variables
- playbooks/site.yml - Main playbook
- roles/ - Ansible roles for installation
