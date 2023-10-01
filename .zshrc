# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/penguin/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# golang
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/gopath
export PATH=$PATH:$GOPATH/bin

# fix windows directory background
export LS_COLORS=$LS_COLORS:'ow=01;34'

# environment ip
get_ip() {
    export win_ip=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
    export wsl_ip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
}

# proxy 
get_proxy() {
    get_ip
    export proxy_socks5="socks5://${win_ip}:30808"
    export proxy_socks5h="socks5h://${win_ip}:30808"
    export proxy_http="http://${win_ip}:30809"
}

sproxy() {
    get_proxy

    # set http proxy
    export {http_proxy,HTTP_PROXY}=${proxy_http}

    # set socks proxy (local DNS)
    # export {http_proxy, HTTP_PROXY}=${proxy_socks5}

    # set socks proxy (remote DNS)
    # export {http_proxy, HTTP_PROXY}=${proxy_socks5h}

    export {https_proxy,HTTPS_PROXY}=${http_proxy}
    export {ftp_proxy,FTP_PROXY}=${http_proxy}
    export {rsync_proxy,RSYNC_PROXY}=${http_proxy}
    export {all_proxy,ALL_PROXY}=${http_proxy}

    export {no_proxy,NO_PROXY}="127.0.0.1,localhost,.localdomain.com"
}

cproxy() {
    unset {http,https,ftp,rsync,all}_proxy {HTTP,HTTPS,FTP,RSYNC,ALL}_PROXY
    unset no_proxy NO_PROXY
}

sproxy_proxychains() {
    config="$HOME/.proxychains/proxychains.conf"
    config_bak="${config}.proxybak"
    template="$HOME/.proxychains/proxychains.conf.template"
    template_tmp="${template}.tmp"

    get_proxy
    proxy_socks5_ip=$(echo ${proxy_socks5} | awk -F'[/:]' '{print $4}')
    proxy_socks5_port=$(echo ${proxy_socks5} | awk -F'[/:]' '{print $5}')
    proxy_http_ip=$(echo ${proxy_http} | awk -F'[/:]' '{print $4}')
    proxy_http_port=$(echo ${proxy_http} | awk -F'[/:]' '{print $5}')

    cp "${template}" "${template_tmp}"
    sed -i "s/proxy_socks5_ip/${proxy_socks5_ip}/g" "${template_tmp}"
    sed -i "s/proxy_socks5_port/${proxy_socks5_port}/g" "${template_tmp}"
    sed -i "s/proxy_http_ip/${proxy_http_ip}/g" "${template_tmp}"
    sed -i "s/proxy_http_port/${proxy_http_port}/g" "${template_tmp}"
    if [ -f "${config_bak}" ]; then
        mv "${config_bak}" "${config}"
    fi 
    cp "${config}" "${config_bak}"
    sed -i "\$r ${template_tmp}" "${config}"
    rm "${template_tmp}"
}

cproxy_proxychains() {
    config="$HOME/.proxychains/proxychains.conf"
    config_bak="${config}.proxybak"
    template="$HOME/.proxychains/proxychains.conf.template"

    if [ -f "$config_bak" ]; then 
        mv "$config_bak" "$config"
    fi
}

sproxy_npm() {
    get_proxy
    npm config set proxy ${proxy_http}
    npm config set https-proxy ${proxy_http}
    yarn config set proxy ${proxy_http}
    yarn config set https-proxy ${proxy_http}
}

cproxy_npm() {
    npm config delete proxy
    npm config delete https-proxy
    yarn config delete proxy
    yarn config delete https-proxy
}

sproxy_git() {
    get_proxy
    # git config --global http.proxy ${proxy_socks5h}
    git config --global http.https://github.com.proxy ${proxy_socks5h}
    ssh_proxy=$(echo ${proxy_socks5} | awk -F'/' '{print $3}')
    if ! grep -qF "Host github.com" ~/.ssh/config ; then
        echo "Host github.com" >> ~/.ssh/config
        echo "    User git" >> ~/.ssh/config
        echo "    ProxyCommand nc -X 5 -x ${ssh_proxy} %h %p" >> ~/.ssh/config
    else
        lino=$(($(awk '/Host github.com/{print NR}'  ~/.ssh/config)+2))
        sed -i "${lino}c\    ProxyCommand nc -X 5 -x ${ssh_proxy} %h %p" ~/.ssh/config
    fi
}

cproxy_git() {
    git config --global --unset http.https://github.com.proxy
    # still need to edit .ssh/config manually
}

sproxy_docker() {
    config="$HOME/.docker/config.json"
    config_bak="${config}.proxybak"
    template="$HOME/.docker/config.json.template"
    template_tmp="${template}.tmp"

    get_proxy
    cp "${template}" "${template_tmp}"
    sed -i "s#proxy_http_full#${proxy_http}#g" "${template_tmp}"
    sed -i "s#proxy_https_full#${proxy_http}#g" "${template_tmp}"
    if [ -f "${config_bak}" ]; then
        mv "${config_bak}" "${config}"
    fi
    cp "${config}" "${config_bak}"
    sed -i "1r ${template_tmp}" "${config}"
    rm "${template_tmp}"
}

cproxy_docker() {
    config="$HOME/.docker/config.json"
    config_bak="${config}.proxybak"
    template="$HOME/.docker/config.json.template"

    if [ -f "${config_bak}" ]; then
        mv "${config_bak}" "${config}"
    fi
}

# transport 0.0.0.0 to 127.0.0.1
expose_local(){
    sudo sysctl -w net.ipv4.conf.all.route_localnet=1 >/dev/null 2>&1
    sudo iptables -t nat -I PREROUTING -p tcp -j DNAT --to-destination 127.0.0.1
}

# prepare v2ray
sproxy_v2ray() {
    get_ip
    config="/etc/v2ray/config.json"
    template="/etc/v2ray/config.json.template"
    template_tmp="${template}.tmp"

    get_proxy
    proxy_socks5_ip=$(echo ${proxy_socks5} | awk -F'[/:]' '{print $4}')
    proxy_socks5_port=$(echo ${proxy_socks5} | awk -F'[/:]' '{print $5}')
    proxy_http_ip=$(echo ${proxy_http} | awk -F'[/:]' '{print $4}')
    proxy_http_port=$(echo ${proxy_http} | awk -F'[/:]' '{print $5}')

    sudo cp "${template}" "${template_tmp}"
    sudo sed -i "s/@@@proxy_socks5_ip@@@/${proxy_socks5_ip}/g" "${template_tmp}"
    sudo sed -i "s/@@@proxy_socks5_port@@@/${proxy_socks5_port}/g" "${template_tmp}"
    sudo sed -i "s/@@@proxy_http_ip@@@/${proxy_http_ip}/g" "${template_tmp}"
    sudo sed -i "s/@@@proxy_http_port@@@/${proxy_http_port}/g" "${template_tmp}"
    sudo cp "${template_tmp}" "${config}" 
    sudo rm "${template_tmp}"
}

sproxy_all() {
    export {http_proxy,HTTP_PROXY}="http://127.0.0.1:30811"
    export {https_proxy,HTTPS_PROXY}=${http_proxy}
    export {ftp_proxy,FTP_PROXY}=${http_proxy}
    export {rsync_proxy,RSYNC_PROXY}=${http_proxy}
    export {all_proxy,ALL_PROXY}=${http_proxy}
    export {no_proxy,NO_PROXY}="127.0.0.1,localhost"
    export {npm_config_proxy,NPM_CONFIG_PROXY}=${http_proxy}
    export {npm_config_https_proxy,NPM_CONFIG_HTTPS_PROXY}=${http_proxy}
    export YARN_HTTP_PROXY=${http_proxy}
    export YARN_HTTPS_PROXY=${http_proxy}
} 

cproxy_all() {
    unset {http_proxy,HTTP_PROXY}
    unset {https_proxy,HTTPS_PROXY}
    unset {ftp_proxy,FTP_PROXY}
    unset {rsync_proxy,RSYNC_PROXY}
    unset {all_proxy,ALL_PROXY}
    unset {no_proxy,NO_PROXY}
    unset {npm_config_proxy,NPM_CONFIG_PROXY}
    unset {npm_config_https_proxy,NPM_CONFIG_HTTPS_PROXY}
    unset YARN_HTTP_PROXY
    unset YARN_HTTPS_PROXY
} 

# VcSrv
export DISPLAY=$WIN_IP:0
export LIBGL_ALWAYS_INDIRECT=1

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
# unsetopt LIST_BEEP
