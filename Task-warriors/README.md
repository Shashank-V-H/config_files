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

## **3. Keep the wrapper function the same**
