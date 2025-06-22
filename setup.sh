#!/bin/bash



function check_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "MacOS"
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "Cygwin (Windows)"
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "MSYS (Windows)"
    elif [[ "$OSTYPE" == "win32" ]]; then
        echo "Windows"
    else
        echo "Unknown OS: $OSTYPE"
    fi
}
function check_distribution() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "$NAME"
    elif [[ -f /etc/lsb-release ]]; then
        . /etc/lsb-release
        echo "$DISTRIB_ID"
    elif [[ -f /etc/debian_version ]]; then
        echo "Debian"
    elif [[ -f /etc/redhat-release ]]; then
        echo "Red Hat"
    else
        echo "Unknown distribution"
    fi
}   




os=$(check_os)
distribution=$(check_distribution)

if [[ "$os" == "Linux" && ( "$distribution" == "Arch Linux" || "$distribution" == "EndeavourOS" ) ]]; then
   
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed."
        sudo pacman -Sy docker
        # Start Docker Service
        echo "Starting Docker service..."
        sudo systemctl enable docker.service
        sudo systemctl start docker.service
    fi  
    # pulling docker image
    # Check if docker is running
    
    docker run -d -p 10200:5000 -v /home/aruncs/docker/data:/data rhasspy/wyoming-piper --voice en_US-lessac-medium
    if ! command -v pip &> /dev/null; then
        echo "pip is not installed."
        sudo pacman -Sy python-pip
    fi
    if [ -d ~/AI_Assistant_app ]; then
        echo "AI_Assistant_app directory already exists. Skipping cloning."
    else
        echo "Cloning AI_Assistant_app repository..."
        cd ~ && git clone https://github.com/aruncs31s/AI_Assistant_app
    fi
    cd ~/AI_Assistant_app
    echo "Installing Python dependencies..."
    python3 -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
else
    echo "Unsupported OS or distribution: $os $distribution"
    exit 1
fi