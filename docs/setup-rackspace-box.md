Setup the Kristoffer (cayuga) Box on Rackspace
==============================================

Using Ubuntu 10.04 LTS

After starting the box on Rackspace, get the IP address and put it into the A
record on the zone file for kristo.us at DynDNS. Then put the new root password
and IP address into the Rackspace entries in KeePassX.

Login as root, update the instance, and install dependencies.

    ssh -p 22 root@kristo.us

    sudo apt-get update
    sudo apt-get dist-upgrade -m -y
    sudo apt-get autoremove -m -y

    sudo apt-get install \
        openssh-server \
        openssh-client \
        build-essential \
        screen \
        curl \
        vim \
        git-core \
        tree

Then, while still logged in as root, create a named user and a git user.  Use
KeePass to generate the password and save it.

    adduser kris
    adduser git

Add the named user to the sudo group.

    adduser kris sudo

Lockdown SSH. Edit the `/etc/ssh/sshd_config` file with

    Port 2575
    PermitRootLogin no
    AllowUsers git kris

Restart the server, then back on the local box (the development VM); add the
SSH keys. But, check the local .ssh/conf first to make sure entries exist for
these users.

    ssh-copy-id kris@kristo.us
    ssh-copy-id git@kristo.us

Check to make sure the users can login (except the root user), then [create an image](http://www.rackspace.com/knowledge_center/index.php/Creating_a_Cloud_Server_from_a_Backup_Image)

Set up the [remote git repositories](http://tumblr.intranation.com/post/766290565/how-set-up-your-own-private-git-server-linux).