#!/bin/bash

sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
