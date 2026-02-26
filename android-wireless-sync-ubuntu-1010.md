# Android and wireless sync with Ubuntu 10.10 (for free)

The idea: **Ubuntu ↔ SMB** sync and **SMB ↔ Android** sync using free tools.

1. Set up SMB: use an old laptop drive on a BT Home Hub 1.5. USB voltage may be insufficient; external 5V supply is safer. Format the disk as FAT32.
2. Set up Ubuntu SMB mount (possibly via `/etc/fstab`):

   ```fstab
   //192.168.1.253/bt_7g /media/NetworkDisk cifs username=USERNAME,password=PASSWORD,file_mode=0777,dir_mode=0777,users 0 0
   ```

3. Set up sync. Purists: `rsync`. Simpler option: **Conduit**.
4. Create relevant folders on the SD card.
5. Install a Samba client on Android (e.g., **PCFileSync**). Add SD card folders and the SMB folders and sync.
