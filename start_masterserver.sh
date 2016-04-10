#/bin/bash
cd /root/Cigar
ip=$1
port=$2
node="node"
sed -e "s/%SERVERIP%/${ip}/" -e "s/%SERVERPORT%/${port}/" masterserver.ini_template > masterserver.ini
which apt-get > /dev/null
if [ "$?" -eq "0" ]; then
	node=$(which nodejs)
	if [ "$?" -ne "0" ]; then
		echo "Could not find nodejs! Please run \"apt-get install nodejs\" to install it."
		exit 1
	fi
	echo "[BATCH] Debian detected. Using nodejs instead of node..."
fi
echo [BATCH] Starting Server with MasterServer
while true
do
	clear
	$node server/index.js --master
	echo -------------------------------------------------------
	echo [BATCH] Server Shutdown, waiting 15 seconds before a restart.
	sleep 15
done
