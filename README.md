# T-FLEX DOCs Ansible Project

## Overview

This project provides an automated solution for deploying T-FLEX DOCs Server 17 on Windows environments using Ansible. It streamlines the installation and configuration process, reducing manual setup time and ensuring consistency across multiple deployments.

## Purpose

T-FLEX DOCs is a comprehensive document management and collaboration platform. This Ansible project automates:

- **Server Installation**: Automated T-FLEX DOCs Server 17 deployment on Windows machines
- **Configuration Management**: Centralized configuration through inventory and variable files
- **Environment Setup**: Automatic environment validation and dependency installation
- **Deployment Consistency**: Reproducible deployments across development, staging, and production environments

## Key Features

- **Infrastructure as Code (IaC)**: Define your infrastructure in version-controlled YAML files
- **Idempotent Operations**: Safe to run multiple times without causing unintended side effects
- **Modular Design**: Organized roles for different installation phases
- **Cross-Platform Support**: Setup scripts for both Windows and macOS control nodes
- **Quick Start Scripts**: Rapid deployment with minimal configuration
- **Environment Validation**: Built-in checks to verify system readiness

## Quick Start

### Prerequisites

- Ansible 2.9+ installed on your control node
- Windows target servers with WinRM enabled
- SSH or WinRM connectivity from control node to target servers
- Appropriate permissions on target systems

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/shelmanovoo/ansible-tflex-docs.git
   cd ansible-tflex-docs
   ```

2. **Configure your inventory**
   ```bash
   # Edit inventory/hosts.ini with your server details
   nano inventory/hosts.ini
   ```

3. **Set up variables**
   ```bash
   # Configure global variables
   nano group_vars/all.yml
   ```

4. **Run the playbook**
   ```bash
   ansible-playbook -i inventory/hosts.ini playbooks/site.yml
   ```

### Quick Deployment Scripts

For rapid setup:

```bash
# Check environment compatibility
./check-environment.sh

# Setup for macOS control nodes
./setup-macos.sh

# Deploy with minimal configuration
./quick-deploy.sh
```

## Project Structure

```
ansible-tflex-docs/
├── inventory/           # Inventory configuration
│   └── hosts.ini       # Server definitions and grouping
├── group_vars/         # Group-level variables
│   └── all.yml         # Global configuration variables
├── playbooks/          # Ansible playbooks
│   └── site.yml        # Main deployment playbook
├── roles/              # Reusable Ansible roles
│   ├── prerequisites/  # System prerequisites and dependencies
│   ├── installation/   # T-FLEX DOCs installation
│   ├── configuration/  # Server configuration
│   └── validation/     # Post-installation validation
├── requirements.yml    # Ansible Galaxy dependencies
├── check-environment.sh    # Environment validation script
├── quick-deploy.sh         # Quick deployment automation
├── setup-macos.sh          # macOS setup script
├── start-here.sh           # Getting started script
├── README.md              # This file
└── PORTFOLIO.md           # Project portfolio documentation
```

## Configuration

### Inventory Configuration (inventory/hosts.ini)

Define your target servers and group them logically:

```ini
[tflex_servers]
server1.example.com ansible_user=administrator ansible_password=password
server2.example.com ansible_user=administrator

[tflex_servers:vars]
ansible_connection=winrm
ansible_winrm_scheme=https
ansible_port=5986
```

### Global Variables (group_vars/all.yml)

Set common configuration parameters:

```yaml
# T-FLEX DOCs installation directory
tflex_install_path: "C:\\TFLEXDocs"

# Database configuration
db_server: "db.example.com"
db_name: "tflex_docs"
db_user: "sa"

# License and activation
license_key: "your-license-key"
```

## Usage Examples

### Deploy to All Servers

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

### Deploy to Specific Server Group

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml -l development
```

### Run with Verbose Output

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml -vvv
```

### Check Mode (Dry Run)

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml --check
```

## Roles

### Prerequisites Role
Handles system requirements validation and preparatory tasks.

### Installation Role
Manages the T-FLEX DOCs Server installation process.

### Configuration Role
Applies server-specific configurations and customizations.

### Validation Role
Verifies successful installation and proper functionality.

## Environment Setup

### macOS Control Node Setup

```bash
./setup-macos.sh
```

This script installs:
- Ansible
- Required Python packages
- WinRM connector (for Windows management)

## Troubleshooting

### Common Issues

**WinRM Connection Errors**
- Ensure WinRM is enabled on target Windows servers
- Verify firewall rules allow WinRM traffic (port 5985/5986)
- Check credentials in inventory configuration

**Module Not Found Errors**
- Run `ansible-galaxy install -r requirements.yml` to install dependencies

**Permission Denied Errors**
- Verify the Ansible user has appropriate permissions
- Check Windows Group Policy settings for script execution

## Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Submit a Pull Request

## Best Practices

- **Always test playbooks in a test environment first**
- **Use version control for all infrastructure code**
- **Document any custom configurations**
- **Regularly review and update dependencies**
- **Implement proper access controls for sensitive data**
- **Monitor deployments and maintain audit logs**

## Security Considerations

- Store sensitive data (passwords, API keys) in ansible-vault encrypted files
- Use WinRM over HTTPS (port 5986) rather than HTTP
- Restrict inventory file access through file permissions
- Regularly audit and update security group rules
- Keep Windows target systems patched and up-to-date

## Documentation

For more detailed information, see:
- **PORTFOLIO.md** - Project portfolio and detailed documentation
- Individual role README files for specific documentation
- T-FLEX DOCs official documentation for product-specific details

## Support

For issues and questions:
- Check existing GitHub issues
- Review T-FLEX DOCs documentation
- Contact the development team

## License

This project is provided as-is for T-FLEX DOCs deployment automation.

## Authors

- **shelmanovoo** - Project creator and maintainer
- **olegsh60** - Contributor

## Version History

- **v1.0** - Initial release with basic T-FLEX DOCs installation support
- Supports T-FLEX DOCs Server 17
- Windows Server 2016 and later

## Related Resources

- [T-FLEX DOCs Official Documentation](https://www.t-flex.ru/)
- [Ansible Documentation](https://docs.ansible.com/)
- [Windows Remote Management (WinRM)](https://docs.microsoft.com/en-us/windows/win32/winrm/about-windows-remote-management)

---

**Last Updated**: January 2026
**Maintained by**: shelmanovoo
