#!/bin/sh
# One-click installer: Xray-core 25.12.8-1 for OpenWrt (mipsel_24kc)
# Usage (run on the router):
#   wget -O - https://raw.githubusercontent.com/pasankodi2018/X-ray-core-old-version/main/install.sh | sh
set -e

REPO="pasankodi2018/X-ray-core-old-version"
BRANCH="main"
IPK="openwrt-xray_25.12.8-1_mipsel_24kc.ipk"
URL="https://raw.githubusercontent.com/$REPO/$BRANCH/packages/$IPK"
TMP="/tmp/$IPK"

echo ">> Checking router architecture..."
ARCH="$(opkg print-architecture 2>/dev/null | awk '{print $2}' | grep -x 'mipsel_24kc' || true)"
if [ -z "$ARCH" ]; then
    echo "ERROR: this package is built for mipsel_24kc only."
    echo "Your router reports: $(opkg print-architecture 2>/dev/null | awk '$3>1{print $2}' | tr '\n' ' ')"
    exit 1
fi

FREE_KB="$(df -k /tmp | awk 'NR==2{print $4}')"
[ "${FREE_KB:-0}" -lt 25000 ] && { echo "ERROR: not enough free space in /tmp (need ~25MB)."; exit 1; }

echo ">> Downloading $IPK ..."
rm -f "$TMP"
if command -v wget >/dev/null 2>&1; then
    wget -O "$TMP" "$URL" || { echo "wget failed (try: opkg update && opkg install wget-ssl ca-bundle)"; exit 1; }
elif command -v curl >/dev/null 2>&1; then
    curl -fL -o "$TMP" "$URL"
else
    echo "ERROR: neither wget nor curl found."; exit 1
fi

echo ">> Installing..."
opkg install --force-reinstall "$TMP"
rm -f "$TMP"

echo ">> Done. Installed: $(opkg list-installed openwrt-xray)"
echo "   Binary: $(command -v xray || echo /usr/bin/xray)"
