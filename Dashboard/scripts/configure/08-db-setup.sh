#!/bin/bash
# Create DB and user
sudo -u postgres psql <<EOF
CREATE USER myappuser WITH PASSWORD 'pass123';
CREATE DATABASE myappdb OWNER myappuser;
GRANT ALL PRIVILEGES ON DATABASE myappdb TO myappuser;
EOF
echo "CREATED DB AND USER"

PG_HBA_FILE="/etc/postgresql/18/main/pg_hba.conf"
sudo bash -c "cat >> $PG_HBA_FILE <<EOF
host    all             all     127.0.0.1/8     md5
host    all             all     172.0.0.0/8     md5
host    all             all     50.50.0.170/8     md5
EOF"

sudo bash -c "cat >> /etc/postgresql/18/main/postgresql.conf <<EOF
listen_addresses = '*'
#port = 5432
EOF"

sudo systemctl restart postgresql

