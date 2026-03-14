# Azure Ubuntu NAT Gateway 🚀

A lightweight and cost-effective solution to provide Internet access to Azure Virtual Machines, avoiding the fixed costs of the standard Azure NAT Gateway.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fgarria%2Fazure-nat-gw-ubuntu%2Fmain%2Fdeploy%2Fazuredeploy.json)

---

⚠️ Disclaimer
This project is provided "as is" for testing and educational purposes only. It is not intended for production environments. By using this solution, you acknowledge that you are responsible for any security, maintenance, or connectivity risks. I do not assume any liability for potential data loss, service downtime, or security breaches resulting from the use of this template. Use at your own risk.

🛠 What does it do?
This template automatically deploys a Linux-based NAT Gateway. It performs the following actions:

Networking: Sets up a VNet, a NAT Subnet, and a Workload Subnet.

Routing: Configures a Route Table to force outbound traffic through the NAT VM.

Security & Automation: Provisions a VM with an embedded script that:

Enables IP Forwarding.

Configures nftables for secure Masquerading (NAT).

Implements MSS Clamping (1350 bytes) to prevent MTU-related packet drops.

Optimizes conntrack for high-volume concurrent connections.

🚀 How to use it
Click the button below to deploy everything directly to your Azure Portal:

Automated vs. Manual Configuration
When the deployment page opens, the system will handle most of the heavy lifting.

What is automated:

All infrastructure components (VNet, NIC, Route Table).

The IP address assignment for the Gateway VM (dynamically calculated within your subnet).

The entire OS-level configuration (NAT, Firewall, MSS Clamping).

What you need to provide:

VNet & Subnet Details: Choose your preferred VNet name and address spaces.

VM Specs: Select your preferred VM size (default is Standard_B2ats_v2).

Instance Name: Choose a unique name for your Gateway VM.

💡 Why use this over Azure NAT Gateway?
While the official Azure NAT Gateway is a managed, highly available service, it comes with a fixed cost. This solution is ideal for:

Development & Testing: Keep costs down in non-production environments.

Learning: Gain a better understanding of how Linux NAT and Azure routing work.

Small workloads: Suitable for lightweight scenarios where high availability is not the primary requirement.

Need help?
If you encounter any issues, please check the Azure Deployment Troubleshooting guide.

Prossimi passi
