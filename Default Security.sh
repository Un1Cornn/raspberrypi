#Update System
sudo apt update
sudo apt upgrade

#--------------------------------------------------------------------------------------------------------------------
#Install the unattended-upgrades package (Auto Patch Pi)
sudo apt install unattended-upgrades
#Open the configuration file:
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
#Open this file
sudo nano /etc/apt/apt.conf.d/02periodic
#Paste these lines (the file should be empty if not, change the values)
APT::Periodic::Enable “1”;
APT::Periodic::Update-Package-Lists “1”;
APT::Periodic::Download-Upgradeable-Packages “1”;
APT::Periodic::Unattended-Upgrade “1”;
APT::Periodic::AutocleanInterval “1”;
APT::Periodic::Verbose “2”;
#This will enable an automatic update every day
#Save and exit (CTRL+O, CTRL+X)
#This should be ok, you can debug your configuration with this command:
sudo unattended-upgrades -d

#--------------------------------------------------------------------------------------------------------------------
#Disable the pi user
#Create a new user:
sudo adduser <username>
#Give him the sudo privilege if needed:
sudo adduser <username> sudo
#This will add your new user to the sudo group.
#Check that everything is working correctly (ssh access, sudo, …).
#Copy files from the pi user to the new user if needed:
sudo cp /home/pi/Documents/* /home/<username>/Documents/ ...
#Delete the pi user:
sudo deluser -remove-home pi

#--------------------------------------------------------------------------------------------------------------------
#Install Firewall module (Uncomplicated FireWall)
sudo apt install ufw

#Allow default SSH port
#Restrict to one IP: sudo ufw allow from 192.168.1.100 port 22
sudo ufw allow 22
#Home Assistant: 
#sudo ufw allow 8123
#PiHole
#sudo ufw allow 53
#sudo ufw allow 80

#Enable Firewall
sudo ufw enable

#Check current rules
sudo ufw status verbose

#--------------------------------------------------------------------------------------------------------------------
#SSH: Prevent root login
#Open the SSH server configuration file:
sudo nano /etc/ssh/sshd_config
#Find this line: 
PermitRootLogin prohibit-password
#If you have something else, comment on this line (by adding # at the beginning).
#Save and exit (CTRL+O, CTRL+X).
#Restart the SSH server if you changed anything in the configuration file:
sudo service ssh restart

#--------------------------------------------------------------------------------------------------------------------
#Make sudo require a password
#Edit this file
sudo nano /etc/sudoers.d/010_pi-nopasswd
#Find this line: 
Username pi ALL=(ALL) NOPASSWD: ALL
#Replace it with
Username ALL=(ALL) PASSWD: ALL
#Save and exit (CTRL+O, CTRL+X)

#--------------------------------------------------------------------------------------------------------------------
#Install Fail2ban
sudo apt install fail2ban
#By default, fail2ban will ban the attacker 10 min after 5 failures.
#I think it’s ok to start, but if you want to change this, all the configuration is in the /etc/fail2ban folder.
#Mainly in /etc/fail2ban/jail.conf:
sudo nano /etc/fail2ban/jail.conf
#Restart the service if you change anything:
sudo service fail2ban restart
