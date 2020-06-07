
NODE1_HOST := localhost:8091
NODE2_HOST := localhost:8092
NODE3_HOST := localhost:8093


start-node1:
	go run main.go -id node01 -haddr ${NODE1_HOST} -raddr localhost:8088 ./.raftdb1

start-node2:
	go run main.go -id node02 -haddr ${NODE2_HOST} -raddr localhost:8089 -join ${NODE1_HOST} ~/.raftdb2

start-node3:
	go run main.go -id node03 -haddr ${NODE3_HOST} -raddr localhost:8090 -join ${NODE1_HOST} ~/.raftdb3

run-post:
	curl -XPOST ${NODE1_HOST}/key -d '{"foo": "bar"}' -L

run-get:
	curl -XGET ${NODE1_HOST}/key/foo -L

run-delete:
	curl -XDELETE ${NODE2_HOST}/key/foo -L
