#/bin/bash

# Needs to be run with sudo

function info {
	bold=$(tput bold)
	normal=$(tput sgr0)

	echo -n "${bold}"
	echo -n  "> $1"
	echo "${normal}"
}

info "Checking failed services"
systemctl --failed
echo ""

info "Cleaning paccache"
paccache -r
echo ""

info "Removing orphans"
pacman -Qtdq | pacman -Rns -
echo ""

info "Searching for broken links"
find / -not \( -path /run -prune \) -not \( -path /proc -prune \) -xtype l -print
echo ""

info "Starting S.M.A.R.T. disk check"
disk='/dev/sda'
mins=$(smartctl -c $disk | grep 'Extended self-test' -A 1 | tail -1 | grep -e '[0-9+]' -o)
secs=$(( 60 * mins + 1))
smartctl -t long $disk
echo "Waiting for results for $secs s..."
echo ""
sleep $secs
smartctl -l selftest $disk
echo ""

