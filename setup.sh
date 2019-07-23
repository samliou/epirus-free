#!/bin/bash
ip=""
number_of_node=5

if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup.sh {ip} {number_of_node}"
    exit 1
fi

if [ "$1" != "" ]; then
  ip=$1
fi
if [ "$2" != "" ]; then
  number_of_node=$2
fi
  
./cleanup.sh

cat templates/.env \
    | sed s:_IP_:$ip:g \
          > .env

cat templates/docker-compose.yml \
    | sed s:_IP_:$ip:g \
          > docker-compose.yml

cp templates/5xx.html ./
cp templates/nginx.conf ./

echo "[" > node.json
n=1
while [ $n -le $number_of_node ]
do
    port=$(( $n + 22000 ))
    sep=`[[ $n !=  $number_of_node ]] && echo ","`
        cat >> node.json <<EOF
    {
		"name": "$ip:$port",
		"script": "app.js",
		"log_date_format": "YYYY-MM-DD HH:mm Z",
		"merge_logs": false,
		"watch": false,
		"max_restarts": 10,
		"exec_interpreter": "node",
		"exec_mode": "fork_mode",
		"env": {
			"NODE_ENV": "production",
			"RPC_HOST": "$ip",
			"RPC_PORT": "$port",
			"LISTENING_PORT": "30303",
			"INSTANCE_NAME": "$ip:$port",
			"CONTACT_DETAILS": "",
			"WS_SERVER": "http://localhost:8091",
			"WS_SECRET": "Hello",
			"VERBOSITY": 2
		}
	}${sep}
EOF

    let n++
done
echo "]" >> node.json

echo "Finished monitor's configuration!"