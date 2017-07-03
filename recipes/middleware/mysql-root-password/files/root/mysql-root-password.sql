update mysql.user set authentication_string=password('root') where user='root';
flush privileges;
