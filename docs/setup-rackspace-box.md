Setup the Kristoffer (cayuga) Box on Rackspace
==============================================


Initial Rackspace Setup
-----------------------
Using Ubuntu 10.04 LTS

After starting the box on Rackspace, put the new root password and IP address
into the Rackspace entries in KeePassX. Then get the IP address and put it into
the A record on the zone file for kristo.us at DynDNS.

Login as root, and get a toehold on the machine.

    ssh -p 22 root@kristo.us
    wget https://github.com/kixxauth/cayuga/raw/master/toehold
    source toehold

This will install git, clone a read-only copy of the cayuga repository, update
Ubuntu, and install dependencies.


Maintenance Updates
-------------------
To keep the sytem updated, jut pull the latest repo and re-run the bootstrap script.

    cd ~/cayuga
    git pull origin master
    bin/bootstrap_ubuntu


Users
-----
Then, while still logged in as root, create a named user and a git user.  Use
KeePass to generate the password and save it.

    adduser kris
    adduser git

Add the named user to the sudo group.

    adduser kris sudo


SSH
---
Lockdown SSH. `sudo vim /etc/ssh/sshd_config` and add or change the following lines:

    Port 2575
    PermitRootLogin no
    AllowUsers git kris

Restart the machine and then back on a local box, copy the SSH keys to the new
private server for the users who should be permitted to login.

!GOTCHA:
When using ssh-copy-id to copy keys to the new server, the `~/.ssh/config` file
needs to be setup properly to make the transfer for each user. Use this as an
example:

    Host kristo.us
      HostName kristo.us
      User kris
      IdentityFile ~/.ssh/id_rsa
      Port 2575

Also, specify the `-i` option, otherwise all the IDs in `~/.ssh/` will be
transferred (see the ssh-copy-id man page).

    ssh-copy-id -i ~/.ssh/id_rsa kris@kristo.us
    ssh-copy-id -i ~/.ssh/id_rsa git@kristo.us


Snapshot Image
--------------
Check to make sure the users can login (except the root user), then [create an image](http://www.rackspace.com/knowledge_center/index.php/Creating_a_Cloud_Server_from_a_Backup_Image)

It would probably be a good idea to do the Home Sync Directory (below) while
logged in as the kris user.


Home Sync Directory
-------------------
We need to create a directory specifically for the rysnc scripts which sync
HOME between machines. While in the SSH term, do this:

    mkdir /home/kris/Homesync


Git Repositories
----------------
Checkout the `docs/` for setting up git repos.


CouchDB
-------
First, make sure the `cayuga` repository is up to date, then just run the
setup script.

    cd ~/cayuga
    git pull origin master
    bin/setup_couchdb


Node.js Web Server
------------------
First, make sure the `cayuga` repository is up to date, then just run the
setup script.

    cd ~/cayuga
    git pull origin master
    bin/setup_node_platform

This will install Node.js, CoffeeScript, and create the nodeserver user and
permissions.
