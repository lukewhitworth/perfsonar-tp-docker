#! /bin/bash

/etc/init.d/rysylog start
/etc/init.d/postgresql start
/etc/init.d/apache2 start
/etc/init.d/owamp-server start
/etc/init.d/twamp-server start

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
