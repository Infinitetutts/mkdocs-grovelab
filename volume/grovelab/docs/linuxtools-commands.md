## Sensu

**Clear dashboard**
```
sensu-cli event list --format json | jq --raw-output "map(select( .[\"check\"][\"issued\"]  )) | .[] | .client.name + \" \" +  .check.name " | xargs --verbose --no-run-if-empty -n2 sensu-cli resolve 
```

## Ansible

**Run playbook**
```
ansible-playbook -i inventory/foo/hosts -l webservers -u ubuntu -S install_sensu.yml 
```     
`-i` = inventory file, `-l` = server group, `-u` = ssh user, `-S` = playbook

**Send ping to all servers within host file**
```
ansible all -m ping -i hosts 
```

## ElasticSearch

**Delete logs**
```
20 0 * * * /usr/local/bin/curator --host 127.0.0.1 delete indices --older-than 30 --time-unit days --timestring '%Y.%m.%d'
```

**Get indices and shard info**
```
curl -XGET "http://localhost:9200/_cat/shards?v"
curl -XGET "http://localhost:9200/_cat/indices"
```

**Get indexes**
```
curl -XGET 'http://localhost:9200/filebeat*/_aliases?pretty'
```

**Get Index Sizes**
```
curl localhost:9200/index1,index2/_stats
curl localhost:9200/filebeat-2016.07.13/_stats
```

**Delete Indexes**
```
curl -XDELETE 'http://localhost:9200/twitter/'
```

**Node Stats**
```
curl -XGET "http://localhost:9200/_nodes/stats?v" | jq .
```

**Cluster info**
```
curl -XGET 'http://localhost:9200/_cluster/health?pretty'
curl -XGET 'http://localhost:9200/_cluster/state'
```

**Node Info**
```
curl -XGET 'http://localhost:9200/_nodes'
curl -XGET 'http://localhost:9200/_nodes/stats'
```

**Filebeat-2016.07.13 (jq displays in json format)**
```
curl localhost:9200/filebeat-2016.07.13,filebeat-2016.07.12/_stats | jq .
```

## Redis

**Connect to redis host**
```
redis-cli -h 192.168.1.1
```

**Commands**

`info`      – Displays ALL info, (Starting point)   
`info stats`      – Displays select info    
`config get maxmemory-policy`   
`config set maxmemory-policy volatile-lru`  
`config get maxmemory`  
`config set maxmemory 20000000000`  
`config get \*`      – Displays all configurable variables 
`slowlog get 25`      – Displays the top 25 slow queries  
`resetstat`      –  Resets stats (Not all)  
`help config resetstat`      – Explains Command 


**Watch Command**
```
watch redis-cli -h 192.168.1.1 info stats
```

**Eviction policies**   

The exact behavior Redis follows when the maxmemory limit is reached is configured using the maxmemory-policyconfiguration directive.

The following policies are available:   
`noeviction`: return errors when the memory limit was reached and the client is trying to execute commands that could result in more memory to be used (most write commands, but DEL and a few more exceptions).    
`allkeys-lru`: evict keys trying to remove the less recently used (LRU) keys first, in order to make space for the new data added.    
`volatile-lru`: evict keys trying to remove the less recently used (LRU) keys first, but only among keys that have anexpire set, in order to make space for the new data added.  
`allkeys-random`: evict random keys in order to make space for the new data added.  
`volatile-random`: evict random keys in order to make space for the new data added, but only evict keys with anexpire set.  
`volatile-ttl`: In order to make space for the new data, evict only keys with an expire set, and try to evict keys with a shorter time to live (TTL) first. 
