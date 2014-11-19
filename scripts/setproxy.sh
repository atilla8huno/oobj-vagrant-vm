# Copy this file to /etc/profile.d to make it global
# and run with every shell.

#PROXY="http://10.239.70.252:3100/"
PROXY="http://10.239.68.43:3128/" 

export http_proxy=$PROXY
export https_proxy=$PROXY
export ftp_proxy=$PROXY
export no_proxy=localhost,127.0.0.0/8

