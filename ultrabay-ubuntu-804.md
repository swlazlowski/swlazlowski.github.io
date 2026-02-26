# Ultrabay under Ubuntu 8.04 – hotswapping made easy

ThinkPads come with a handy bay; detailed description is available here. ThinkWiki has a useful article on enabling them here. Due to kernel/module order issues, change initial kernel boot options.

```bash
cat /proc/acpi/ibm/bay
# status:   occupied
# commands: eject
```
