# Explicit X11 clipboard push build

This package is an isolated FreeRDP 3 X11 build. It does not replace the Debian
`xfreerdp3` executable:

- packaged files are installed below `/opt/freerdp-clipboard`;
- `/usr/bin/xfreerdp3-clipboard` is the only additional command;
- separate builds target Debian 13 and Ubuntu 24.04 on amd64;
- CI installs each generated package in its matching distribution container;
- audio, FFmpeg video/audio codecs, printer, smart-card, Kerberos, FUSE and USB
  redirection support are enabled.

Download the package matching your distribution from the latest
**Cross-platform clipboard builds** release and install it:

```sh
sudo apt install ./freerdp3-clipboard_*_amd64.deb
```

Start the isolated client with both clipboard directions restricted:

```sh
xfreerdp3-clipboard \
  /v:server.example.com \
  /u:username \
  /clipboard:direction-to:local,files-to:local
```

Normal remote-to-local text and file clipboard transfer remains enabled.
Normal local-to-remote text and file clipboard transfer is rejected. With the
RDP window focused, press `Super+Shift+V` to explicitly announce the current
non-file X11 clipboard formats to that one RDP session. After the remote side
accepts the format list, the client sends `Shift+Insert` to paste it. The shortcut is
consumed locally and is not forwarded to the remote desktop.

File formats are deliberately excluded from the forced path. A later ordinary
local clipboard change revokes any unused forced authorization, and a successful
format-data response consumes it.

Remove only this isolated build with:

```sh
sudo apt remove freerdp3-clipboard
```
