## Postgres
# https://mgdm.net/weblog/postgresql-in-a-nix-shell/
#destroy_db:
#    rm -rf $PWD/tmp/postgresql
#init_db:
#    initdb -D $PWD/tmp/postgresql
#start_db:
#    pg_ctl -D $PWD/tmp/postgresql -l logfile -o "--unix_socket_directories='$PWD/tmp'" start
#stop_db:
#    pg_ctl -D $PWD/tmp/postgresql stop

## Mysql/MariaDB
#destroy_db:
#    rm -rf $PWD/tmp/mysql
#init_db:
#    mysql_install_db --auth-root-authentication-method=normal \
#    --datadir=$PWD/tmp/mysql/data \
#    --pid-file=$PWD/tmp/mysql/mysql.pid
#start_db: 
#    mysqld --datadir=$PWD/tmp/mysql/data --pid-file=$PWD/tmp/mysql/mysql.pid \
#      --socket=$PWD/tmp/mysql/mysql.sock 2> $PWD/tmp/mysql/mysql.log &
#stop_db:
#    mysqladmin -u root --socket=$PWD/tmp/mysql/mysql.sock shutdown
#    rm -f $PWD/tmp/mysql/mysql.sock

#setup_db: init_db start_db
#    bin/rails db setup

#setup: setup_db

supervisord:
    @./bin/services/supervisord
    
start *args="all": supervisord
    supervisorctl -c $PWD/supervisord.conf start {{ args }}
    
stop *args="all": supervisord
    supervisorctl -c $PWD/supervisord.conf stop {{ args }}

restart *args="all": supervisord
    supervisorctl -c $PWD/supervisord.conf restart {{ args }}
