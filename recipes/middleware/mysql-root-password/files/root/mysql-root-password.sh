set -e

rm -f /root/ahi

install -m 0755 -o mysql -g root -d /var/run/mysqld
/usr/sbin/mysqld --skip-grant-tables --skip-networking &
sleep 2

mysql -u root < /root/mysql-root-password.sql
killall -TERM mysqld
