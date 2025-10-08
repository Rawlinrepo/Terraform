#!/bin/bash
# Install Nginx and configure reverse proxy
sudo apt install nginx -y
echo "NGINX INSTALLED"
sudo tee /etc/nginx/sites-available/default > /dev/null <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF
sudo systemctl reload nginx
echo "NGINX CONFIGURED"