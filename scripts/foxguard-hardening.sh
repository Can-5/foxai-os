#!/usr/bin/env bash
# FoxGuard system hardening for FoxAI OS (Fedora 44)
# Apply on first boot or via systemd unit.
set -euo pipefail

# SELinux enforcing
if command -v setenforce >/dev/null 2>&1; then
    setenforce 1 || true
fi
sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config 2>/dev/null || true

# Firewalld default-deny (only SSH + established)
if systemctl is-active --quiet firewalld 2>/dev/null; then
    firewall-cmd --set-default-zone=drop >/dev/null 2>&1 || true
    firewall-cmd --permanent --zone=drop --add-service=ssh >/dev/null 2>&1 || true
    firewall-cmd --reload >/dev/null 2>&1 || true
fi

# Disable telemetry services
for svc in fedora-third-party telemetry fstrim.timer; do
    systemctl disable --now "$svc" 2>/dev/null || true
done

# Kernel hardening sysctl
cat >/etc/sysctl.d/99-foxguard.conf <<'EOF'
kernel.kptr_restrict=2
kernel.dmesg_restrict=1
kernel.unprivileged_bpf_disabled=1
net.ipv4.tcp_syncookies=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
EOF
sysctl --system >/dev/null 2>&1 || true

echo "FoxGuard hardening applied."
