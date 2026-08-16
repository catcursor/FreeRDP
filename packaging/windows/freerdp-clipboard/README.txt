FreeRDP explicit clipboard push build for Windows x64
=====================================================

Run the native client from the bin directory:

  wfreerdp.exe /v:server /u:username /clipboard:direction-to:local,files-to:local

Normal remote-to-local clipboard transfer remains enabled. Normal
local-to-remote transfer is blocked. With the RDP window focused, press
Win+Shift+V to send the current non-file host clipboard data once. After the
remote side accepts the clipboard formats, FreeRDP automatically sends Shift+Insert
to paste into the focused remote application.

The hotkey is handled only by the focused FreeRDP process and is not registered
as a system-wide Windows hotkey. File clipboard formats are intentionally not
included in the forced transfer.
