# OpenVPN-and-Transmission-Configuration-Management-Script
This script manages the OpenVPN and Transmission services on a Linux system. It checks if the OpenVPN service is running, and if not, it stops the Transmission service and starts the OpenVPN service. It then waits for the tun0 interface to be up and running. After verifying that the OpenVPN and Transmission services are running, the script gets the IP address of the tun0 interface and the current bind-address-ipv4 setting in the Transmission configuration file. If the bind-address-ipv4 setting does not match the tun0 IP address, the script updates the configuration file and restarts the Transmission service to apply the new configuration.

This script can be run as a cron job to ensure that the Transmission configuration matches the tun0 IP address every few hours.
Prerequisites

Before using this script, make sure that you have:

    A Linux system with the OpenVPN and Transmission services installed
    A working OpenVPN configuration file

Installation

To use this script, follow these steps:

     Copy the script to a directory on your machine (e.g., /opt/scripts).
    Make the script executable with the following command: chmod +x /opt/scripts/transmission-openvpn-auto-config.sh
    Set up a cron job to run the script periodically. For example, to run the script every three hours, add the following line to your crontab (crontab -e): 0 */3 * * * /opt/scripts/transmission-openvpn-auto-config.sh > /dev/null 2>&1
    Check the cron log to confirm that the script is running as expected.
 
License

This script is licensed under the MIT License. See the LICENSE file for details.
Disclaimer

This script is provided as-is, and the author assumes no responsibility for any damages that may occur from its use. Use at your own risk.
