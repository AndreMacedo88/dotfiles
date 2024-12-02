# This file is read by .bashrc at startup

# My functions:

function ch() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        lh
}

# Move file or directory and create a softlink to the moved file, in the original location 
function mv_ln() {
    original="$1" target="$2"
    if [ -d "$target" ]; then
      target="$target/${original##*/}"
    fi
    mv -- "$original" "$target"
    ln -s -- "$target" "$original"
}

# Yazi shell wrapper that provides the ability to change the current working directory when exiting Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Configure APT proxies:
function dkfzapt {
	apt_prox="http://www-int2:80"
	file=/etc/apt/apt.conf.d/proxy
	if [ -f "$file" ];
	then
		echo "Unsetting apt proxies"
		sudo rm /etc/apt/apt.conf.d/proxy
		sudo snap set system proxy.http=""
		sudo snap set system proxy.https=""
	else
		echo "Setting apt proxies"
		apt_conf_proxy="
		Acquire::http::Proxy \"$apt_prox\";
		Acquire::https::Proxy \"$apt_prox\";
		Acquire::ftp::Proxy \"$apt_prox\";
		"
		sudo snap set system proxy.http=$apt_prox
		sudo snap set system proxy.https=$apt_prox
	echo $apt_conf_proxy | sudo tee /etc/apt/apt.conf.d/proxy > /dev/null
	fi
}

# Mount OpenStack drives
function dkfzmounts {
	sudo mount -t cifs -v -o uid=1000,iocharset=utf8,domain=AD,sec=ntlmssp,credentials=/etc/samba/credentials //ad/fs/g381-daten2/ /mnt/o_drive/
	sudo sshfs -o allow_other,default_permissions,IdentityFile=/home/andrem/Documents/OpenStackVM/AndreMain.pem ubuntu@10.128.129.72:/ /mnt/openstack
	sudo sshfs -o allow_other,default_permissions,IdentityFile=/home/andrem/Documents/OpenStackVM/AndreMain.pem ubuntu@10.128.129.72:/mnt/weird_vol/ /mnt/weird_fs
	# sudo sshfs -o allow_other,default_permissions,follow_symlinks,IdentityFile=/home/andrem/.ssh/Andre_cluster.pem a752o@odcf-worker02.dkfz.de:/home/a752o/ /mnt/cluster_w2	
}

function dkfzmounts_dienst {
	sudo mount -t cifs -v -o uid=1000,iocharset=utf8,domain=AD,sec=ntlmssp,credentials=/etc/samba/credentials //ad/fs/g381-daten2/ /mnt/o_drive/
}

function gdmount {
	if mountpoint -q /mnt/google_drive;
	then
		echo "Unmounting Google Drive from /mnt/google_drive"
		fusermount -u /mnt/google_drive
	else
		echo "Mounting Google Drive at /mnt/google_drive"
		google-drive-ocamlfuse /mnt/google_drive
	fi
}

# Old settings:
#sudo sshfs -o allow_other,default_permissions,follow_symlinks a752o@odcf-worker01.dkfz.de:/home/a752o/ /mnt/cluster_w1	
#sudo sshfs -o allow_other,default_permissions,IdentityFile=/home/andrem/Documents/OpenStackVM/AndreMain.pem ubuntu@10.128.129.72:/mnt/o_drive/ /mnt/o_fs
