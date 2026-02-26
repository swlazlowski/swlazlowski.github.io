# Debian 3.1r3 on ThinkPad T42

- The description of the laptop can be found here.
- Debian stable (3.1r3) was installed using the network install, as described here.
- The vanilla install was largely left unchanged, as almost everything worked.
- The only glitch was due to the presence of a protected part of the disk reserved by T42 for extra features (system backup). This part occupies initial disk sectors and prohibits boot-up using GRUB. The solution is to:
  - install GRUB somewhere else (beginning of your Linux partition, e.g., `/dev/hda3`)
  - transfer initial portion of that partition to a file:

    ```bash
    dd if=/dev/hda3 of=debian.img bs=512 count=1
    ```

  - transfer the file to Win32 partition:

    ```text
    c:\debian.img
    ```

  - append your GNU/Linux distribution to Win32 bootloader (in `c:\boot.init`):

    ```text
    c:\debian.img="Debian 3.1r3"
    ```

This is explained all over the net, for example here. Other excellent HowTo’s describing installation of GNU/Linux on the machine can be found here.
