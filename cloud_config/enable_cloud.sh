copy and merge .env.app.cloud to ../config/.env.app
copy and merge .env.catalog.cloud to ../config/.env.catalog
../docker compose up  -> in a new process/thread 
wait for everything to be up and running.
nginx -c nginx.conf
echo Everything is UP!