drop user if exists 'dbuser'@'localhost';
create user 'dbuser'@'localhost' identified by 'abc123';
grant all privileges on *.* to 'dbuser'@'localhost';
flush privileges;
