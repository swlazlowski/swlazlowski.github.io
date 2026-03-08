# Ultrabay under Ubuntu 8.04 – hotswapping made easy

- ThinkPads come with a handy bay; detailed description is available https://www.thinkwiki.org/wiki/How_to_hotswap_Ultrabay_devices
- ThinkWiki has a useful article on enabling them https://www.thinkwiki.org/wiki/Ultrabay
  
   Due to kernel/module order issues, change initial kernel boot options.

```bash
cat /proc/acpi/ibm/bay
# status:   occupied
# commands: eject
```
