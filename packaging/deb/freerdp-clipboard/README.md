# Explicit X11 clipboard push build

This package is an isolated FreeRDP 3 X11 build. It does not replace the Debian
`xfreerdp3` executable:

- packaged files are installed below `/opt/freerdp-clipboard`;
- `/usr/bin/xfreerdp3-clipboard` is the only additional command;
- the build targets Debian 12/13 on amd64.

Download the `freerdp3-clipboard-debian-amd64-*` artifact from the latest
successful **Debian X11 clipboard build** workflow run, extract the artifact,
and install the package:

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
RDP window focused, press `Ctrl+Shift+V` to explicitly announce the current
non-file X11 clipboard formats to that one RDP session. The shortcut press and
release are consumed locally and are not forwarded to the remote desktop.

File formats are deliberately excluded from the forced path. A later ordinary
local clipboard change revokes any unused forced authorization, and a successful
format-data response consumes it.

Remove only this isolated build with:

```sh
sudo apt remove freerdp3-clipboard
```
