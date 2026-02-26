# Nokia 6230 over Bluetooth under Ubuntu 8.04

- Install `wammu` and `gammu`. Do *not* use gammu auto-config.
- Turn on Bluetooth in the laptop and pair your mobile. You may need bluez tools.
- Example scan:

```bash
sudo hcitool scan
# Output:
# Scanning ...
# 00:12:37:F8:6B:2F    Si’s Nokia 6230
```

Edit `~/.gammurc` as follows:

```ini
[gammu]
port = 00:12:37:F8:6B:2F
model = 6230
connection = bluephonet
synchronizetime = yes
logfile = gammulog
logformat = textall
use_locking = no
gammuloc = locfile
startinfo = yes
gammucoding = utf8
rsslevel = teststable
usephonedb = yes
name=
```

Start Wammu → **Phone > Connect**. Everything should work, including calendar and sending messages (which normally would not be available using the AT protocol suggested by auto‑config in Wammu).

If you want to automate the sync, follow:

```bash
msynctool --addgroup evolution-nokia
msynctool --addmember evolution-nokia evo2-sync
msynctool --addmember evolution-nokia syncml-obex-client
msynctool --configure evolution-nokia 1
```

```xml
<?xml version="1.0"?>
<config>
  <address_path>file:///home/swlazlowski/.evolution/addressbook/local/system</address_path>
  <calendar_path>file:///home/swlazlowski/.evolution/calendar/local/system</calendar_path>
  <tasks_path>file:///home/swlazlowski/.evolution/tasks/local/system</tasks_path>
</config>
```

```bash
msynctool --configure evolution-nokia 2
```

```xml
<?xml version="1.0"?>
<config>
  <bluetooth_address>00:12:37:F8:6B:2F</bluetooth_address>
  <bluetooth_channel>11</bluetooth_channel>
  <interface>0</interface>
  <identifier>PC Suite</identifier>
  <version>1</version>
  <wbxml>1</wbxml>
  <username></username>
  <password></password>
  <type>2</type>
  <usestringtable>1</usestringtable>
  <onlyreplace>0</onlyreplace>
  <recvLimit>10000</recvLimit>
  <maxObjSize>0</maxObjSize>
  <contact_db>Contacts</contact_db>
  <calendar_db>Calendar</calendar_db>
  <note_db>Notes</note_db>
</config>
```

```bash
msynctool --sync evolution-nokia --filter-objtype note --filter-objtype event --conflict 1 --slow-sync todo
```
