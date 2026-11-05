# Xray-core (old version) for OpenWrt

Prebuilt `openwrt-xray` 25.12.8-1 package for **mipsel_24kc** routers.

## One-click install

SSH into your router and run:

```sh
wget -O - https://raw.githubusercontent.com/pasankodi2018/X-ray-core-old-version/main/install.sh | sh
```

If wget fails with an SSL error:

```sh
opkg update && opkg install wget-ssl ca-bundle
```

## Manual install

```sh
wget -O /tmp/xray.ipk https://raw.githubusercontent.com/pasankodi2018/X-ray-core-old-version/main/packages/openwrt-xray_25.12.8-1_mipsel_24kc.ipk
opkg install /tmp/xray.ipk
```

Package originates from [yichya/openwrt-xray](https://github.com/yichya/openwrt-xray) (MPLv2).
