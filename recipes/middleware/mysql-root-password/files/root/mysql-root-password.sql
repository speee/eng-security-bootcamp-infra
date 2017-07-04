update mysql.user set authentication_string=password('root'), plugin='mysql_native_password' where user='root';
flush privileges;
