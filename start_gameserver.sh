#/bin/bash
cd /root/Cigar
ip=$1
port=$2
masterIP=$3
masterPort=$4
region=$5
node="node"
sed -e "s/%SERVERIP%/${ip}/" -e "s/%SERVERPORT%/${port}/" -e "s/%SERVERMASTERIP%/${masterIP}/" -e "s/%SERVERMASTERPORT%/${masterPort}/" -e "s/%REGION%/${region}/" gameserver.ini_template > gameserver.ini

which apt-get > /dev/null
if [ "$?" -eq "0" ]; then
	node=$(which nodejs)
	if [ "$?" -ne "0" ]; then
		echo "Could not find nodejs! Please run \"apt-get install nodejs\" to install it."
		exit 1
	fi
	echo "[BATCH] Debian detected. Using nodejs instead of node..."
fi
echo [BATCH] Starting Server without MasterServer
while true
do
	clear
	$node server/index.js --nomaster
	echo -------------------------------------------------------
	echo [BATCH] Server Shutdown, waiting 15 seconds before a restart.
	sleep 15
done
