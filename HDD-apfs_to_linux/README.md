
## **Arch Linux: Installing and Mounting APFS**

### 1️⃣ **Problem**

You wanted to mount an APFS partition (`/dev/sdb2`) on your Linux system. You were initially having issues with:

* Package downloads failing due to slow/unavailable mirrors.
* Mounting APFS giving `Permission denied (os error 13)`.

---

### 2️⃣ **Steps Taken**

#### **A. Installing Required Tools**

1. Updated your package database (initial mirror issues were fixed by editing `/etc/pacman.conf` and commenting out slow mirrors).
2. Installed **`apfs-fuse`** from the AUR using `yay`:

```bash
yay -S apfs-fuse-git
```

* Dependencies installed: `cmake`, `rhash`, `cppdap`.
* Built from source using `CMake`.
* Handled build warnings (mostly harmless about signed/unsigned comparisons and unused parameters).

---

#### **B. Preparing the Mount Point**

1. Created a directory to mount the APFS partition:

```bash
sudo mkdir /mnt/apfs
```

---

#### **C. Mounting the APFS Partition**

1. Attempted initial mount:

```bash
sudo apfs-fuse /dev/sdb2 /mnt/apfs
```

* Resulted in: `Permission denied (os error 13)`.

2. Fixed by using **FUSE option `allow_other`** and ensuring `/etc/fuse.conf` allows it:

```bash
sudo nano /etc/fuse.conf
# Uncomment:
user_allow_other
```

3. Mounted properly:

```bash
sudo apfs-fuse -o allow_other /dev/sdb2 /mnt/apfs
```

4. Verified the mount:

```bash
ls /mnt/apfs
```

Files should now be visible and accessible.

---

### 3️⃣ **Unmounting / Safely Removing the Drive**

When you want to disconnect the APFS drive:

```bash
sudo umount /mnt/apfs
```

* Always **unmount** before physically removing the drive to avoid data corruption.

Optional: remove the mount directory if not needed:

```bash
sudo rmdir /mnt/apfs
```

---

### 4️⃣ **Reconnecting the Drive in the Future**

1. Create the mount point (if it doesn’t exist):

```bash
sudo mkdir -p /mnt/apfs
```

2. Mount the APFS partition again with `allow_other`:

```bash
sudo apfs-fuse -o allow_other /dev/sdb2 /mnt/apfs
```

3. Verify contents:

```bash
ls /mnt/apfs
```

Everything should be accessible as before.

---

### ✅ **Key Notes**

* APFS on Linux is **read-only** with `apfs-fuse` unless using experimental options.
* `allow_other` is needed for root or other users to access a FUSE mount.
* Always check `/etc/fuse.conf` when using `allow_other`.
* Using `yay` to build AUR packages ensures the latest source is used if standard repos don’t have the package.
* Always **unmount before removing** the drive.

