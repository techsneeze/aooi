
Overveiw:

Atomic Offline Operating System Installer (AOOI) is a tool to install Centos or Cloudlinux on a system offline using either transient swap space, or over a network.  It was originally designed to re-image dedicated systems at hosting facilities.

It allows you to install, or reinstall Linux on an existing Linux or Windows system remotely. It will automatically partition the drives and install Linux non-interactively, and will reboot the system into a working installation.

This allows you to rebuild a Windows or Linux system into a working Linux installation remotely, without having local or console access to the system quickly and automatically.


Usage:


Linux:
wget -O - https://raw.githubusercontent.com/atomicturtle/aooi/master/aooi |sh

Windows
Download and run AOOI4WIN.vbs


Notes:

The default root password for AOOI installed systems is "atomic"


