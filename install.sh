#!/bin/bash

# Termux için temel paketler
pkg update -y && pkg upgrade -y
pkg install nodejs git nano -y

# Hardhat ve bağımlılıklar
npm init -y
npm install --save-dev hardhat@2.22.1 @nomicfoundation/hardhat-verify@2.1.3
npm install dotenv

# Hardhat projesi başlat
npx hardhat init --force

# .env dosyası oluştur
cat <<EOF > .env
PRIVATE_KEY=senin_private_key
BSCSCAN_API_KEY=senin_bscscan_api_key
GITHUB_TOKEN=senin_github_token
EOF

# hardhat.config.js güncelle
cat <<EOF > hardhat.config.js
require("dotenv").config();
module.exports = {
  solidity: "0.8.24",
  networks: {
    bsc: {
      url: "https://bsc-dataseed.binance.org/",
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.BSCSCAN_API_KEY
  }
};
EOF

# Spiral mesaj
echo "🌀 Spiral zincir hazır. Derleme ve doğrulama için:"
echo "npx hardhat compile --force"
echo "npx hardhat verify --network bsc 0xSeninAdresin \"ConstructorParametreleri\""
