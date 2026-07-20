# Research Report: UFW `.rules` Files Configuration

## Overview
**UFW (Uncomplicated Firewall)** acts as a frontend for Linux netfilter/iptables. Core configuration settings are stored inside `/etc/ufw/` in files ending with the `.rules` extension. These files determine how packets are handled at different stages.

---

## 1. Key `.rules` Files Breakdown

### A. `before.rules` & `before6.rules`
* **Execution Order:** Processed **1st** (before any command-line rules).
* **Primary Function:** Core networking setup.
* **Key Components:**
  * **Loopback:** Allows internal loopback traffic (`127.0.0.1`).
  * **Connection State:** Grants `ESTABLISHED,RELATED` incoming traffic for outbound requests.
  * **ICMP (Ping):** Automatically permits ping requests (`echo-request`) and network status codes.
  * **Services:** Allows DHCP client requests (ports 67/68) and mDNS/UPnP multicast discovery.
  * **IP Differences:** `before.rules` manages IPv4; `before6.rules` manages IPv6.

### B. `user.rules` & `user6.rules`
* **Execution Order:** Processed **2nd**.
* **Primary Function:** Managed directly through `ufw` CLI actions (e.g., `sudo ufw allow 22`).
* **Key Components:**
  * Contains user-added allow/deny port rules.
  * Sets up rate-limiting chains (`ufw-user-limit`) for brute-force defense.
  * `user.rules` manages IPv4; `user6.rules` manages IPv6.

### C. `after.rules` & `after6.rules`
* **Execution Order:** Processed **3rd** (last).
* **Primary Function:** Log management and cleanup.
* **Key Components:**
  * Silently drops noisy background traffic (NetBIOS/Samba ports 137–139, 445, and LAN broadcasts) without cluttering logs.
  * `after.rules` manages IPv4; `after6.rules` manages IPv6.

---

## 2. Comparison Summary

| File Pair | Order | Primary Purpose | How It Is Edited |
| :--- | :--- | :--- | :--- |
| `before.rules` / `before6.rules` | 1st | Loopback, ICMP/Ping, DHCP, NAT | Manually by Administrator |
| `user.rules` / `user6.rules` | 2nd | Custom open/closed ports (SSH, HTTP) | Automatically via `ufw` CLI |
| `after.rules` / `after6.rules` | 3rd | Suppressing broadcast/Samba log noise | Manually by Administrator |

---

## 3. Viewing and Management Commands

```bash
# Read file contents (Requires sudo)
sudo cat /etc/ufw/before.rules
sudo cat /etc/ufw/user.rules
sudo cat /etc/ufw/after.rules

# Reload UFW to apply manual updates
sudo ufw reload
