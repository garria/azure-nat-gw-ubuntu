# Azure Ubuntu NAT Gateway 🚀

A lightweight and cost-effective solution to provide Internet access to Azure Virtual Machines, avoiding the fixed costs of the standard Azure NAT Gateway.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fgarria%2Fazure-nat-gw-ubuntu%2Fmain%2Fdeploy%2Fazuredeploy.json)

---

## ⚠️ Disclaimer

This project is provided **“as‑is”** for **test/lab/PoC/education**.  
You are solely responsible for security, maintenance, and operational risk.  
No liability is assumed for downtime, data loss, or security incidents. **Use at your own risk.**

---

## 🛠 What this template does

This template deploys an Ubuntu VM configured as a **NAT gateway** using **nftables**—with everything automated via **ARM + cloud‑init**.

### Networking
- Creates a **VNet** with:
  - Subnet **`natgw`** (hosts the gateway VM)
  - **Workload** subnet (for your application VMs)
- Enables **IP forwarding** on the VM NIC.

### Routing
- Creates a **Route Table**.
- Adds default route **`0.0.0.0/0 → Virtual Appliance (Gateway VM private IP)`**.
- Associates the route table to the workload subnet.

### OS configuration (cloud‑init, first boot only)
- Sets `net.ipv4.ip_forward=1` (**persistent** via `sysctl.d`)
- Installs and configures **nftables**
- Adds **NAT (MASQUERADE)** on `eth0`
- Applies **MSS clamping** (`1350`) to mitigate MTU issues
- Disables **UFW** and **netfilter‑persistent** (to avoid rule conflicts)
- Enables **`nftables.service`** so `/etc/nftables.conf` is reloaded on **every boot**

> No manual configuration inside the VM is required.

---

## 🚀 How to use

1. Click **Deploy to Azure** above.
2. Provide:
   - VM name, admin credentials
   - VNet address space and subnet CIDRs
   - Workload subnet name/prefix and the static private IP for the gateway VM
3. Click **Review + Create**.

The template provisions the full setup end‑to‑end.

---

## ⚡ What’s automated vs. what you decide

**Automated by the template**
- VNet / Subnets
- Route Table and association
- Public IP + NIC (IP forwarding on, static private IP)
- Gateway VM provisioning
- OS‑level NAT (nftables), MSS clamping, persistence

**You provide**
- Resource names
- Address spaces / CIDRs
- VM size & OS SKU (Ubuntu 22.04 or 24.04)
- Admin credentials

> **Note:** This solution is designed for a **single‑NIC** gateway.  
> If you later add more NICs, tighten the nftables forward rules accordingly.

---

## 💡 Why this instead of Azure NAT Gateway?

Azure NAT Gateway is managed, scalable, and highly available—but it has a **fixed cost**.  
This VM‑based NAT is great when you need:

- **Dev/Test** environments with minimal spend  
- **Learning** (understanding Azure routing + Linux NAT)  
- **Small workloads** where HA is not the primary requirement

---

## 🔎 Post‑deploy validation (Portal → VM → *Run Command* → **RunShellScript**) 

```bash
# Cloud-init should be "done"
cloud-init status --long
sudo tail -n 80 /var/log/cloud-init-output.log

# IP forwarding: runtime + persisted
sysctl net.ipv4.ip_forward
sudo cat /etc/sysctl.d/99-azure-nat.conf

# nftables service + active ruleset
sudo systemctl status nftables --no-pager
sudo nft list ruleset | sed -n '1,200p'
