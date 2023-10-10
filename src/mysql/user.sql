CREATE USER 'exporter'@'%' IDENTIFIED BY 'password-string' WITH MAX_USER_CONNECTIONS 3;
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';

CREATE USER 'backend'@'%' IDENTIFIED BY 'password-string';
GRANT all privileges  ON ticketingdb.* TO 'backend'@'%';

CREATE USER 'k6_init'@'%' IDENTIFIED BY 'password-string';
GRANT all privileges  ON ticketingdb.* TO 'k6_init'@'%';
