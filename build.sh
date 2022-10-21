
image=arjunvk/redis:v5
docker build -t $image .
docker push $image

sleep 5

./re-deploy.sh

