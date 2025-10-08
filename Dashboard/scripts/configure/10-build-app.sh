#!/bin/bash
# Build and start app
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm use default
cd ~/Dashboard
pnpm install
setsid pnpm run dev >> dashboard.log 2>&1 &

# wait until port 3000 is listening
while ! sudo ss -tln | grep -q ':3000'; do
  sleep 1
  echo "Still waiting..."
done
echo "Dashboard running in background !!"
curl http://localhost:3000/seed
curl http://localhost:3000/seed

#Kill the app running on 3000 and free it for docker
PID=$(sudo ss -tlnp | grep ':3000' | awk -F'pid=' '{print $2}' | awk -F',' '{print $1}')
echo "$PID"
sudo kill -9 $PID

#Build the app and run
docker compose build
docker compose up -d
