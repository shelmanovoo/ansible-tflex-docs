#!/bin/bash

echo "=== Starting T-FLEX DOCs Project Setup ==="

# Create directory structure
echo "Creating directory structure..."
mkdir -p inventory group_vars host_vars playbooks
mkdir -p roles/docs_prerequisites/tasks
mkdir -p roles/docs_install/{tasks,templates}
mkdir -p roles/docs_firewall/tasks

# Create .gitignore
echo "Creating .gitignore..."
cat > .gitignore << 'GITEOF'
# Ansible
*.retry
*.swp

# Windows
Thumbs.db

# Sensitive data
*.key
*.pem
vault.yml

# Installers
*.exe
*.msi

# Logs
*.log
GITEOF

# Create inventory file
echo "Creating inventory/hosts.ini..."
cat > inventory/hosts.ini << 'INVEOF'
[windows_servers]
tflex-docs-server ansible_host=192.168.1.100

[windows_servers:vars]
ansible_user=administrator
ansible_password=YourPassword123
ansible_connection=winrm
ansible_winrm_transport=ntlm
ansible_winrm_server_cert_validation=ignore
INVEOF

# Create group_vars
echo "Creating group_vars/all.yml..."
cat > group_vars/all.yml << 'GVEOF'
---
tflex_version: "17"
tflex_instance_name: "SERVERS"
tflex_db_server: "localhost"
tflex_db_name: "TflexDOCsSERVERS"
GVEOF

# Create main playbook
echo "Creating playbooks/site.yml..."
cat > playbooks/site.yml << 'PLAYEOF'
---
- name: Install T-FLEX DOCs Server
  hosts: windows_servers
  gather_facts: false
  
  roles:
    - docs_prerequisites
    - docs_install
    - docs_firewall

  tasks:
    - name: Display completion message
      debug:
        msg: "T-FLEX DOCs installation completed!"
PLAYEOF

# Create prerequisites role
echo "Creating roles/docs_prerequisites/tasks/main.yml..."
cat > roles/docs_prerequisites/tasks/main.yml << 'PREREQEOF'
---
- name: Install IIS
  win_feature:
    name: Web-Server
    state: present

- name: Install .NET Framework
  win_chocolatey:
    name: dotnet-4.8
    state: present
PREREQEOF

# Create install role
echo "Creating roles/docs_install/tasks/main.yml..."
cat > roles/docs_install/tasks/main.yml << 'INSTALLEOF'
---
- name: Copy T-FLEX installer
  win_copy:
    src: T-FLEX_DOCS_Server_17.exe
    dest: C:\\Temp\\T-FLEX_DOCS_Server_17.exe

- name: Install T-FLEX DOCs
  win_package:
    path: C:\\Temp\\T-FLEX_DOCS_Server_17.exe
    arguments: /S
    state: present
INSTALLEOF

# Create firewall role
echo "Creating roles/docs_firewall/tasks/main.yml..."
cat > roles/docs_firewall/tasks/main.yml << 'FWEOF'
---
- name: Open firewall port for app server
  win_firewall_rule:
    name: "T-FLEX DOCs App Server"
    localport: 21333
    action: allow
    direction: in
    protocol: tcp
    state: present
FWEOF

# Create README
echo "Creating README.md..."
cat > README.md << 'READMEEOF'
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
READMEEOF

echo "=== Project structure created successfully ==="
echo "Next: Run 'git init' and 'gh repo create'"
