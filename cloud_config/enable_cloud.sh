cat .env.app.cloud >> ../config/.env.app
cat .env.catalog.cloud >> ../config/.env.catalog
export userID=$(id -u); export groupID=$(id -g)
../docker compose up  -> in a new process/thread 
wait for everything to be up and running.
nginx -c nginx.conf
echo Everything is UP!