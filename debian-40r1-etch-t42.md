# Debian 4.0r1 (Etch) on IBM/Lenovo T42 laptop

Was extremely (or at least supposed to be) straightforward; I simply followed instructions from here.

Please remember to change the distribution name in `/etc/apt/source.list` from **STABLE** to **SARGE** when updating the system the final last time before `dist-upgrade` and then from **SARGE** to **STABLE** when doing `dist-upgrade`.

Side note: I got the internal bay and placed the new hard drive inside. Works under Linux. Timings are:

```text
babu:/home/swlazlowski# hdparm -tT /dev/hda
/dev/hda:
 Timing cached reads:   1108 MB in  2.00 seconds = 553.99 MB/sec
 Timing buffered disk reads:  102 MB in  3.02 seconds =  33.80 MB/sec
babu:/home/swlazlowski# hdparm -tT /dev/hdc
/dev/hdc:
 Timing cached reads:   1348 MB in  2.00 seconds = 673.49 MB/sec
 Timing buffered disk reads:  122 MB in  3.01 seconds =  40.58 MB/sec
```

The hard drive is: **Seagate Momentus 7200.1 ST980825A – 80 GB – 2.5" – ATA**.
