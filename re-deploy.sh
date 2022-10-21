
docker service rm rediscluster_redis
docker stack deploy -c redis.yaml rediscluster
