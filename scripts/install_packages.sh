#!/bin/sh

# Exit on error
set -e

if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run with sudo." >&2
	exit 1
fi

GREEN='\033[32m'
RED='\033[31m'
RESET='\033[0m'

SCRIPT_DIR=$(dirname "$0")
LOG_DIR="$SCRIPT_DIR/logs/install_packages"

mkdir -p "$LOG_DIR"

INSTALLED_LOG="$LOG_DIR/installed.log"
FAILED_LOG="$LOG_DIR/failed.log"
SCRIPT_OUTPUT_LOG="$LOG_DIR/script.log"

: > "$INSTALLED_LOG"
: > "$FAILED_LOG"

PACKAGES="firefox git less util-linux man-db man-pages iputils net-tools iproute2 zip unzip tar neovim wget curl python3 python3-pip fastfetch tmux luarocks"

if command -v apt >/dev/null 2>&1; then
	PKG_MANAGER="apt" 
	UPDATE_CMD="apt update"
	INSTALL_CMD="apt install -y"
elif command -v dnf >/dev/null 2>&1; then
	PKG_MANAGER="dnf" 
	UPDATE_CMD="dnf update -y"
	INSTALL_CMD="dnf install -y"
elif command -v yum 2>/dev/null >&1; then
	PKG_MANAGER="yum" 
	UPDATE_CMD="yum update -y"
	INSTALL_CMD="apt install -y"
elif command -v pacman 2>/dev/null >&1; then
	PKG_MANAGER="pacman" 
	UPDATE_CMD="pacman -Syu --noconfirm"
	INSTALL_CMD="pacman -S --noconfirm"
else
	echo -e "${RED}Unsupported package manager. Exiting.${RESET}"
	echo "Error: No supported package manager found" >> "$FAILED_LOG"
	exit 1
fi

echo "Detected package manager: $PKG_MANAGER"

if [ "$PKG_MANAGER" = "apt" ]; then
	PACKAGES=$(echo "$PACKAGES" | sed 's/firefox/firefox-esr/' | sed 's/iputils/iputils-ping/')
elif [ "$PKG_MANAGER" = "yum" ]; then
	PACKAGES=$(echo "$PACKAGES" | sed 's/iproute2/iproute/')
elif [ "$PKG_MANAGER" = "pacman" ]; then
	PACKAGES=$(echo "$PACKAGES" | sed 's/python3-pip/python-pip/')
fi

echo "Updating package lists..."
if $UPDATE_CMD; then
	echo -e "${GREEN}Package lists updated successfully${RESET}"
else
	echo -e "${RED}Failed to update package lists${RESET}" >> "$FAILED_LOG"
	exit 1
fi

for pkg in $PACKAGES; do
	echo "Installing $pkg..."
	pkg_available=0

	case "$PKG_MANAGER" in
		apt)
			if apt-cache show "$pkg" >/dev/null 2>&1; then
				pkg_available=1
			fi
			;;
		dnf)
			if dnf list "$pkg" >/dev/null 2>&1; then
				pkg_available=1
			fi
			;;
		yum)
			if yum list "$pkg" >/dev/null 2>&1; then
				pkg_available=1
			fi
			;;
		pacman)
			if pacman -Ss "^$pkg$" >/dev/null 2>&1; then
				pkg_available=1
			fi
			;;
	esac

	if [ "$pkg_available" = 0 ]; then
		echo "$pkg not found in repositories" >> "$FAILED_LOG"
		echo -e "${RED}Package $pkg not found, skipping...${RESET}"
		continue
	fi

	if $INSTALL_CMD "$pkg" >/dev/null 2>&1; then
		version=""
		case "$PKG_MANAGER" in
			apt)
				version=$(dpkg-query -f '${Version}' -W "$pkg" 2>/dev/null || echo "unknown")
				;;
			dnf|yum)
				version=$(rpm -q --qf '%{VERSION}-%{RELEASE}' "$pkg" 2>/dev/null || echo "unknown")
				;;
			pacman)
				version=$(pacman -Q "$pkg" | awk '{print $2}' 2>/dev/null || echo "unknown")
				;;
		esac
		
		echo "$pkg (version: $version)" >> "$INSTALLED_LOG"
		echo -e "${GREEN}Successfully installed $pkg${RESET}" | tee -a "$SCRIPT_OUTPUT_LOG"
	else
		echo "$pkg" >> "$FAILED_LOG"
		echo -e "${RED}Failed to install $pkg, continuing...${RESET}" | tee -a "$SCRIPT_OUTPUT_LOG"
	fi
done

echo -e "${GREEN}Package installation completed!${RESET}" | tee -a "$SCRIPT_OUTPUT_LOG"
echo -e "See ${GREEN}$INSTALLED_LOG${RESET} for installed packages and ${RED}$FAILED_LOG${RESET} for failures." | tee -a "$SCRIPT_OUTPUT_LOG"

