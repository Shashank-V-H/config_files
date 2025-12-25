# **Taskwarrior Multi-Machine Git Sync – Simple Documentation**

## **Objective**

Automatically sync your `~/.task` file across multiple machines using Git while minimizing conflicts.

**Workflow:**

1. Pull latest changes before editing tasks.
2. Run Taskwarrior commands.
3. Commit and push changes automatically after editing.

---

## **1. Scripts**

### **Pull Script – `pull_task.sh`**

```bash
#!/bin/bash
# Pull latest changes before editing tasks
cd "$HOME/.task" || exit
git pull --rebase origin main
```

* Make executable:

```bash
chmod +x ~/pull_task.sh
```

---

### **Push Script – `push_task.sh`**

```bash
#!/bin/bash
# Commit & push changes after editing tasks
cd "$HOME/.task" || exit

if git diff --quiet && git diff --cached --quiet; then
    echo "No changes to commit."
else
    git add .
    git commit -m "Auto-update task file $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
fi
```

* Make executable:

```bash
chmod +x ~/push_task.sh
```

---

## **2. Bash Wrapper Function**

Add this to `~/.bashrc` or `~/.zshrc`:

```bash
function task() {
    ~/pull_task.sh      # Step 1: auto-pull
    command task "$@"   # Step 2: run the original Taskwarrior command
    ~/push_task.sh     # Step 3: auto-commit & push
}
```

* Reload `.bashrc`:

```bash
source ~/.bashrc
```

**Usage:**
Run `task add …`, `task done …`, etc., as usual. The wrapper automatically handles pull → edit → push.

---

## **3. Conflict Avoidance Workaround**

* **Pull first:** ensures you have the latest remote changes before adding or editing tasks.
* **Push last:** commits and pushes your changes immediately after editing.
* **Wrapper sequence:** Pull → Task command → Commit & Push.
* This reduces the chances of conflicts when working across multiple machines.

---

This is the minimal setup you need to keep your `.task` file synced safely with Git.


# Updated scripts to supress git messages:

## **1. Update `pull_task.sh`**

```bash
#!/bin/bash
cd "$HOME/.task" || exit

# Pull quietly
git pull --rebase origin main --quiet 2>/dev/null
```

* `--quiet` suppresses normal Git output.
* `2>/dev/null` hides error messages if you want it completely silent.

---

## **2. Update `push_task.sh`**

```bash
#!/bin/bash
cd "$HOME/.task" || exit

# Only commit if there are changes
if git diff --quiet && git diff --cached --quiet; then
    :
else
    git add . >/dev/null 2>&1
    git commit -m "Auto-update task file $(date '+%Y-%m-%d %H:%M:%S')" >/dev/null 2>&1
    git push origin main --quiet >/dev/null 2>&1
fi
```

* `>/dev/null 2>&1` suppresses all standard output and errors.
* `--quiet` for push avoids verbose messages.

---

## **3. Keep the wrapper function the same Or if you don't want to mess up the scripts with --quiet command just update the wrapper function and scripts with basic function is enough**
```bash
function task() {
    ~/pull_task.sh >/dev/null 2>&1     # Silence the pull
    command task "$@"
    ~/push_task.sh >/dev/null 2>&1     # Silence the push
}
```

## **4. Upgrading to Taskwarrior 3.4.2 (v3+ Architecture)**

### **Overview**

Upgraded from 2.6.2 to 3.4.2 to support modern features and cross-device compatibility. This version requires a manual build on older systems (like Ubuntu 22.04) due to modern Rust dependencies and also because I'm using WSL2 which doesn't have latest packages in Package manager `apt`. I can use other package managers but they install higher version than the specific version i want, which makes the compatibility issues with other two devices where i already downloaded the 3.4.2 version.

### **Installation Steps**

1. **Remove conflicts:** Removed `taskwarrior` (apt) and `task` (snap).
2. **Modernize Rust:** Installed the latest Rust toolchain via `rustup` (required version ≥ 1.81.0).
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

```


3. **Build from Source:**
```bash
wget https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v3.4.2/task-3.4.2.tar.gz
tar xzvf task-3.4.2.tar.gz && cd task-3.4.2
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
sudo cmake --install build

# Refresh shell and verify
hash -r
task --version  # Output: task 3.4.2
```

