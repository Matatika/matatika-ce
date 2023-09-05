#Concatenate the .cloud files, with the .env files required for docker compose
cat .env.app.cloud >> ../config/.env.app
cat .env.catalog.cloud >> ../config/.env.catalog

#run docker compose command
export userID=$(id -u); export groupID=$(id -g)
../docker compose up  -> in a new process/thread 
wait for everything to be up and running.

#start nginx
nginx -c <fullpath>/matatika-ce/cloud_config/nginx.conf
echo Everything is UP!