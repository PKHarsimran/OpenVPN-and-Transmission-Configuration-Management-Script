#!/bin/bash

# Log file path
LOG_FILE="/home/pkvirus/openvpn_transmission.log"

# Check OpenVPN status
if systemctl is-active --quiet openvpn.service ; then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): OpenVPN service is running." >> $LOG_FILE
else
  echo "$(date '+%Y-%m-%d %H:%M:%S'): OpenVPN service is not running. Stopping Transmission service and starting OpenVPN service..." >> $LOG_FILE
  
  # Stop Transmission service
  if systemctl is-active --quiet transmission-daemon.service ; then
    systemctl stop transmission-daemon.service
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Transmission service stopped." >> $LOG_FILE
  fi
  
  # Start OpenVPN service
  systemctl start openvpn.service
  
  # Wait for tun0 interface to be up
  while ! ip a show tun0 up; do
    sleep 1
  done
  
  echo "$(date '+%Y-%m-%d %H:%M:%S'): OpenVPN service started." >> $LOG_FILE
fi

# Check Transmission status
if systemctl is-active --quiet transmission-daemon.service ; then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Transmission service is running." >> $LOG_FILE
else
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Transmission service is not running. Starting Transmission service..." >> $LOG_FILE
  systemctl start transmission-daemon.service
fi

# Get the IP address of the tun0 interface
TUN_IP=$(ip addr show tun0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}')

# Get the current bind-address-ipv4 setting in the Transmission configuration file
TRANSMISSION_IP=$(sed -n 's/.*"bind-address-ipv4": "\(.*\)",/\1/p' /etc/transmission-daemon/settings.json)

# If the current bind-address-ipv4 setting does not match the tun0 IP address, update the configuration file
if [[ "$TRANSMISSION_IP" != "$TUN_IP" ]]; then
  # Set the bind-address-ipv4 setting in the Transmission configuration file to the IP address of the tun0 interface
  sudo sed -i "s/\"bind-address-ipv4\": \".*\"/\"bind-address-ipv4\": \"$TUN_IP\"/" /etc/transmission-daemon/settings.json

  # Restart the Transmission service to apply the new configuration
  systemctl start transmission-daemon.service

  echo "$(date '+%Y-%m-%d %H:%M:%S'): Transmission configuration updated to use bind address: $TUN_IP" >> $LOG_FILE
else
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Transmission configuration already using correct bind address: $TUN_IP" >> $LOG_FILE
fi
