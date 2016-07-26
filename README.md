# from_last_sync_forward

Simple shell script for pulling torrents content I downloaded on my raspberry pi to my computer. Uses rsync with ssh to continue from partially transfered files, filter by file types, and only fetches recent files (from last sync forward).

Requirements:
- rsync
- a public/private key pair without password to connect to the server. You can create them with the following commands:
    * ssh-keygen -t rsa
    * ssh-copy-id user@123.45.56.78

Limitations:
- rsync is using --protect-args option, so MAC OS X users will have trouble since this option is not present on MAC
