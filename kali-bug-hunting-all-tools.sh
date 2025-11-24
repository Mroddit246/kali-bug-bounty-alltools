#!/bin/bash
# Bug Hunting Toolkit Installer for Kali Linux (Extended + PATH fix)

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[*] Installing essential packages..."
sudo apt install -y git curl wget python3 python3-pip build-essential unzip make

echo "[*] Installing Go..."
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

TOOLS_DIR=~/tools
mkdir -p $TOOLS_DIR

echo "[*] Installing core bug bounty tools..."
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/owasp-amass/amass/v3/...@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/gf@latest
go install github.com/hahwul/dalfox/v2@latest
sudo apt install -y sqlmap
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
git clone https://github.com/maurosoria/dirsearch.git $TOOLS_DIR/dirsearch
go install github.com/tomnomnom/httprobe@latest
git clone https://github.com/arthaud/git-dumper.git $TOOLS_DIR/git-dumper
go install github.com/haccer/subjack@latest
go install github.com/1ndianl33t/kxss@latest
go install github.com/tomnomnom/qsreplace@latest

echo "[*] Installing extended tools..."
# SecLists
git clone https://github.com/danielmiessler/SecLists.git $TOOLS_DIR/SecLists

# Gobuster
sudo apt install -y gobuster

# Naabu
go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# MassDNS
git clone https://github.com/blechschmidt/massdns.git $TOOLS_DIR/massdns
cd $TOOLS_DIR/massdns && make && cd ~

# DNSenum
sudo apt install -y dnsenum

# Masscan
sudo apt install -y masscan

# Rustscan
sudo apt install -y rustscan

# Gotator
go install github.com/Josue87/gotator@latest

# PureDNS
go install github.com/d3mondev/puredns/v2@latest

echo "[*] Moving Go binaries to /usr/local/bin..."
sudo cp ~/go/bin/* /usr/local/bin/

echo "[*] Moving compiled tools to /usr/local/bin..."
sudo cp $TOOLS_DIR/massdns/bin/massdns /usr/local/bin/

echo "[*] Installation complete! All tools are now globally accessible."
