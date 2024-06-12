1. docker run -d -it --name task-1.4 ubuntu sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'

2. docker exec task-1.4 apt-get update

3. docker exec task-1.4 apt-get -y install curl

4. docker attach task-1.4

5. then input helsinki.fi
