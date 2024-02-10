#!/bin/bash

wget -N https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.23-d901d853.tar.gz

tar -xvzf geth-linux-amd64-1.10.23-d901d853.tar.gz

cd geth-linux-amd64-1.10.23-d901d853/

echo "Please follow the prompt to create an Ethereum account:"
./geth account new --keystore ./keystore

#echo "Ensuring Docker service is started..."
#sudo systemctl start docker

#sudo systemctl enable docker

echo "Pulling the latest NuLink Docker image..."
docker pull nulink/nulink:latest

echo "Preparing the NuLink directory..."
cd /root
mkdir -p nulink

echo "Copying the Ethereum account key to the NuLink directory..."
cp /root/geth-linux-amd64-1.10.23-d901d853/keystore/* /root/nulink

echo "Setting directory permissions..."
chmod -R 777 /root/nulink
echo
read -s -p "Enter NuLink Keystore Password: " NULINK_KEYSTORE_PASSWORD
export NULINK_KEYSTORE_PASSWORD
echo
read -s -p "Enter NuLink Operator ETH Password: " NULINK_OPERATOR_ETH_PASSWORD
export NULINK_OPERATOR_ETH_PASSWORD
echo
echo  "Enter the Ethereum Keystore Path : "  

read  ETH_KEYSTORE_FILENAME


echo "Enter the operator address:"
read WORKER_ADDRESS
docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer keystore:///code/"$ETH_KEYSTORE_FILENAME" \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--payment-network bsc_testnet \
--operator-address "$WORKER_ADDRESS" \
--max-gas-price 10000000000

docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready
echo "Setup completed. Please verify the output and ensure there were no errors."
