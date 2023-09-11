CREATE USER 'exporter'@'%' IDENTIFIED BY 'pw1234' WITH MAX_USER_CONNECTIONS 3;
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';

CREATE USER 'backend'@'%' IDENTIFIED BY 'pw1234';
GRANT all privileges  ON ticketingdb.* TO 'backend'@'%';