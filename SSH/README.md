# SSH connectiviey with .ppk file
## Guide: Connecting to SSH via WSL2 using a .ppk file

### 1. File Format Conversion

Standard Linux/macOS SSH clients (OpenSSH) cannot read PuTTY's `.ppk` format. You must convert it to a `.pem` (OpenSSH) format.

* **Tool:** `puttygen` (part of the `putty-tools` package).
* **Action:** Convert the key.
```bash
puttygen id_key.ppk -O private-openssh -o id_key.pem

```



### 2. Solving the WSL2 Permission Issue

When a file is stored on the Windows filesystem (`/mnt/c/...`), WSL2 treats it with "Windows-style" permissions. SSH requires strict "Linux-style" permissions (`400`), which cannot be applied to files inside `/mnt/c/` by default.

* **Problem:** `chmod 400` appears to run but doesn't actually change the permissions on the Windows mount.
* **Solution:** Move the key to the native Linux filesystem (the home directory).
```bash
# Move key to Linux home
cp /mnt/c/path/to/your/key.pem ~/ATP_server_key.pem

# Apply strict permissions (Read-only for owner)
chmod 400 ~/ATP_server_key.pem

```



### 3. Connection Syntax

Once the key is in the Linux filesystem and permissions are restricted, use the `-i` (identity) flag to point to your key.

```bash
ssh -i ~/ATP_server_key.pem username@server-ip

```

---

### Summary Table for Quick Reference

| Problem | Cause | Solution |
| --- | --- | --- |
| **Invalid format** | `.ppk` is for PuTTY only. | Convert to `.pem` using `puttygen`. |
| **Permissions too open** | SSH rejects keys visible to others. | Run `chmod 400 key.pem`. |
| **chmod fails in WSL2** | Windows mount `/mnt/c` ignores `chmod`. | Move the key to `~/` (Linux home). |

---

### Understanding the Architecture

It helps to visualize why the file move was necessary. The Linux environment inside WSL2 and the Windows filesystem handle file "metadata" (like who owns a file) differently.

