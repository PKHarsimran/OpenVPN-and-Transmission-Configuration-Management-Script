# OpenVPN-and-Transmission-Configuration-Management-Script
This script manages the OpenVPN and Transmission services on a Linux system. It checks if the OpenVPN service is running, and if not, it stops the Transmission service and starts the OpenVPN service. It then waits for the tun0 interface to be up and running. After verifying that the OpenVPN and Transmission services are running, the script gets the IP address of the tun0 interface and the current bind-address-ipv4 setting in the Transmission configuration file. If the bind-address-ipv4 setting does not match the tun0 IP address, the script updates the configuration file and restarts the Transmission service to apply the new configuration.

This script can be run as a cron job to ensure that the Transmission configuration matches the tun0 IP address every few hours.
Prerequisites

Before using this script, make sure that you have:

    A Linux system with the OpenVPN and Transmission services installed
    A working OpenVPN configuration file

Installation

To use this script, follow these steps:

    Download the script to your Linux system.
    Open the script file in a text editor and make any necessary changes to match your system's configuration (e.g., OpenVPN configuration file path).
    Save the script file and exit the text editor.
    Make the script executable by running the following command in the terminal: chmod +x transmission-vpn-manager.sh
    Test the script by running the following command: ./transmission-vpn-manager.sh. The script should output the status of the OpenVPN and Transmission services, and update the Transmission configuration if necessary.
    Add the script as a cron job to run periodically. For example, to run the script every 3 hours, run the following command: crontab -e and add the following line: 0 */3 * * * /path/to/transmission-vpn-manager.sh.

License

This script is licensed under the MIT License. See the LICENSE file for details.
Disclaimer

This script is provided as-is, and the author assumes no responsibility for any damages that may occur from its use. Use at your own risk.
