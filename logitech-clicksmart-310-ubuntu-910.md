# Logitech ClickSmart 310 under Ubuntu 9.10 (Karmic Koala)

`lsusb` gives:

```text
Bus 003 Device 006: ID 046d:0900 Logitech, Inc. ClickSmart 310
```

The camera doesn’t work until you load the correct module:

```bash
modprobe -r gspca_spca500 && modprobe gspca_spca500
```

Then `/dev/video0` is registered.

Create a udev rule:

```bash
sudo gedit /etc/udev/rules.d/91-webcamtrigger.rules
```

```text
ACTION=="add", SUBSYSTEM=="pci", SYSFS{device}=="0x24c4", SYSFS{vendor}=="0x8086", RUN+="/usr/local/bin/webcam.sh"
```

Example script:

```bash
gedit /usr/local/bin/webcam.sh

if [ "${ACTION}" = "add" ] && [ -f "${DEVICE}" ]
then
  echo ${DEVICE} >> /var/log/backuptousbdrive.log
fi
```
