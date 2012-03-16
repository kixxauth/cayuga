CouchDB
=======


Installation
------------
First, make sure the `cayuga` repository is up to date, then just run the
setup script.

    cd ~/cayuga
    git pull origin master
    bin/setup_couchdb

Before you can run CouchDB, you'll have to restart the machine and set the
owner and group level of the installation directory.

    sudo chown -R couchdb /opt/couchdb/
    sudo chgrp -R couchdb /opt/couchdb/


Running CouchDB
---------------
After restarting and setting the user and group:

    sudo su -c /opt/couchdb/bin/couchdb couchdb

Will start CouchDB with stdout going to the console, while

    sudo /opt/couchdb/etc/init.d/couchdb start

will start CouchDB in the background as the `COUCHDB_USER` logging to the
logfile. The `COUCHDB_USER` is set in `/opt/couchdb/etc/default/couchdb` and is
"couchdb" by default.  The logfile can be found in
`/opt/couchdb/etc/couchdb/default.ini` and can be set in
`/opt/couchdb/etc/couchdb/local.ini`.
