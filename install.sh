#!/bin/bash

## Created by @mrrobot1o1

TOOLS_DIR="$HOME/tools"

# Create tools directory if it doesn't exist
mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR" || exit

# Function to install a tool
install_tool() {
    tool_name="$1"
    install_command="$2"

    echo -e "\e[93m[-] Installing $tool_name..."
    eval "$install_command"
    echo -e "$tool_name installed successfully."
}

# Display list of tools
tool_list() {
    echo -e "\e[96mThe following tools are available:\e[0m"
    echo -e "\e[96m  1. nmap\e[0m           \e[96m 11. rpcinfo"
    echo -e "\e[96m  2. rustscan\e[0m       \e[96m 12. enum4linux"
    echo -e "\e[96m  3. nuclei\e[0m         \e[96m 13. nmblookup"
    echo -e "\e[96m  4. ffuf\e[0m           \e[96m 14. smbclient"
    echo -e "\e[96m  5. metasploit\e[0m     \e[96m 15. smbmap.py"
    echo -e "\e[96m  6. dnsrecon\e[0m       \e[96m 16. crackmapexec"
    echo -e "\e[96m  7. sqlmap\e[0m           \e[96m 17. snmpwalk"
    echo -e "\e[96m  8. impacket\e[0m       \e[96m 18. ldapsearch"
    echo -e "\e[96m  9. Responder\e[0m      \e[96m 19. testssl.sh"
    echo -e "\e[96m 10. rpcclient\e[0m       \e[96m 20. ike-scan"
    echo -e "\e[96m 21. evil-winrm\e[0m     \e[96m 22. naabu\e[0m"
}

tool_list

# Prompt user to either install all tools or exclude specific tools
read -p $'\e[93mHit Enter to install all tools or enter the numbers of the tools to exclude (comma-separated):\e[0m ' tool_choice
# Install Go if not already installed

if ! command -v go &> /dev/null; then
    echo -e "\e[93m[-] Installing Go...\e[0m"
    wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo -e "Go installed successfully."
    # Add Go binary directory to PATH in ~/.bashrc
    echo -e 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
    export GO111MODULE=on
    source ~/.bashrc
fi
if ! command -v pip3 &>/dev/null; then
        echo -e "\e[93m[-] Installing pip3...\e[0m"
        apt install python3.8-venv -y
        wget https://bootstrap.pypa.io/get-pip.py
        python3 get-pip.py
        rm get-pip.py
        echo -e "\e[92m[+] pip3 installed successfully.\e[0m"
fi
if ! command -v pipx &>/dev/null; then
        echo -e "\e[93m[-] Installing pipx...\e[0m"
        python3 -m pip install --user pipx
        python3 -m pipx ensurepath
        source ~/.bashrc
        echo -e "\e[92m[+] pip3 installed successfully.\e[0m"
fi

# Install selected tools
IFS=',' read -ra excluded_tools <<< "$tool_choice"
for tool_number in {1..23}; do
    tool_name=$(eval echo -e "\$$tool_number")
    if [[ ! " ${excluded_tools[@]} " =~ " $tool_number " ]]; then
        case $tool_number in
            1 )
                echo -e "\e[93m[-] Installing nmap...\e[0m"
                sudo apt-get install -y nmap
                echo -e "\e[92m[+] nmap installed successfully.\e[0m";;
            2 )
                echo -e "\e[93m[-] Installing rustscan...\e[0m"
                wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
                dpkg -i rustscan_2.0.1_amd64.deb
                rm rustscan_2.0.1_amd64.deb
                echo -e "\e[92m[+] rustscan installed successfully.\e[0m";;
            3 )
                echo -e "\e[93m[-] Installing nuclei...\e[0m"
                go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
                echo -e "\e[92m[+] nuclei installed successfully.\e[0m";;
            4 )
                echo -e "\e[93m[-] Installing ffuf...\e[0m"
                go install github.com/ffuf/ffuf/v2@latest
                echo -e "\e[92m[+] ffuf installed successfully.\e[0m";;
            5 )
                echo -e "\e[93m[-] Installing metasploit...\e[0m"
                curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
                chmod 755 msfinstall
                ./msfinstall
                echo -e "\e[92m[+] metasploit installed successfully.\e[0m";;
            6 )
                echo -e "\e[93m[-] Installing dnsrecon...\e[0m"
                sudo apt install dnsrecon -y
                echo -e "\e[92m[+] dnsrecon installed successfully.\e[0m";;
            7 )
                echo -e "\e[93m[-] Installing sqlmap...\e[0m"
                sudo apt-get install -y python3-pip
                pip3 install --user pipx
                export PATH=$PATH:~/.local/bin
                echo -e "\e[92m[+] pipx installed successfully.\e[0m";;
            8 )
                echo -e "\e[93m[-] Installing impacket...\e[0m"
                pipx install impacket
                echo -e "\e[92m[+] impacket installed successfully.\e[0m";;
            9 )
                echo -e "\e[93m[-] Installing Responder...\e[0m"
                git clone https://gitlab.com/kalilinux/packages/responder
                cd responder
                pip3 install -r requirements.txt
                ln -s "$HOME/tools/responder/Responder.py" /usr/local/bin/Responder.py
                cd "$TOOLS_DIR"
                echo -e "\e[92m[+] Responder installed successfully.\e[0m";;
            10 )
                echo -e "\e[93m[-] Installing rpcclient...\e[0m"
                sudo apt-get install -y samba-common-bin
                echo -e "rpcclient installed successfully.\e[0m";;
            11 )
                echo -e "\e[93m[-] Installing rpcinfo...\e[0m"
                sudo apt-get install -y rpcbind
                echo -e "\e[92m[+] rpcinfo installed successfully.\e[0m";;
            12 )
                echo -e "\e[93m[-] Installing enum4linux...\e[0m"
                git clone https://gitlab.com/kalilinux/packages/enum4linux.git
                ln -s "$HOME/tools/enum4linux/enum4linux.pl" /usr/local/bin/enum4linux
                echo -e "\e[92m[+] enum4linux installed successfully.\e[0m";;
            13 )
                echo -e "\e[93m[-] Installing nmblookup...\e[0m"
                sudo apt-get install -y samba-common-bin
                echo -e "\e[92m[+] nmblookup installed successfully.\e[0m";;
            14 )
                echo -e "\e[93m[-] Installing smbclient...\e[0m"
                sudo apt-get install -y smbclient
                echo -e "\e[92m[+] smbclient installed successfully.\e[0m";;
            15 )
                echo -e "\e[93m[-] Installing smbmap.py...\e[0m"
                git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
                cd sqlmap && ln -s $HOME/tools/sqlmap/sqlmap.py /usr/local/bin/sqlmap.py
                cd $TOOLS_DIR
                echo -e "\e[92m[+] smbmap.py installed successfully.\e[0m";;
            16 )
                echo -e "\e[93m[-] Installing crackmapexec...\e[0m"
                git clone https://github.com/byt3bl33d3r/CrackMapExec
                cd CrackMapExec && git submodule init && git submodule update --recursive
                pipx install .
                cd $TOOLS_DIR
                echo -e "\e[92m[+] crackmapexec installed successfully.\e[0m";;
            17 )
                echo -e "\e[93m[-] Installing snmpwalk...\e[0m"
                sudo apt-get install -y snmp
                echo -e "\e[92m[+] snmpwalk installed successfully.\e[0m";;
            18 )
                echo -e "\e[93m[-] Installing ldapsearch...\e[0m"
                sudo apt-get install -y ldap-utils
                echo -e "\e[92m[+] ldapsearch installed successfully.\e[0m";;
            19 )
                echo -e "\e[93m[-] Installing testssl.sh...\e[0m"
                sudo apt-get install -y testssl.sh
                echo -e "\e[92m[+] testssl.sh installed successfully.\e[0m";;
            20 )
                echo -e "\e[93m[-] Installing ike-scan...\e[0m"
                sudo apt-get install -y ike-scan
                echo -e "\e[92m[+] ike-scan installed successfully.\e[0m";;
            21 )
                echo -e "\e[93m[-] Installing evil-winrm...\e[0m"
                sudo apt-get install -y ruby ruby-dev build-essential libgssapi-krb5-2
                gem install evil-winrm
                echo -e "\e[92m[+] evil-winrm installed successfully.\e[0m";;
            22 )
                echo -e "\e[93m[-] Installing naabu...\e[0m"
                sudo apt install -y libpcap-dev
                go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
                echo -e "\e[92m[+] naabu installed successfully.\e[0m";;
            # Add more tools as needed
        esac
    fi
done

source ~/.bashrc
echo -e "\e[92mTool installation completed successfully.\e[0m"
echo -e "\e[94mHappy hacking :)\e[0m"
