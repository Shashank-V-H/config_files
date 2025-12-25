# Why does this happen? Sometimes if i use the later added ssh key to push something it won't show in the streak bubble of github, until i use that repo in first added ssh machine. then it commits after usage of that repo in first added ssh machine starts to appear in git-hub bubble. but commits will show no matter.

This happens because of a subtle distinction in how Git and GitHub work: **SSH keys handle "Permission" (Who is allowed to push), but Email addresses handle "Attribution" (Who gets the credit).**

When you use a new machine with a new SSH key, your commits may not be showing up in the GitHub streak bubble because the **Git Email** on that new machine is likely not configured or doesn't match your GitHub account.

---

### 1. The "Ghost Author" Problem

When you commit on your first machine, you probably set your email long ago. On your **second system**, Git might be using a default like `user@your-server-name.local`.

* **SSH Key:** Tells GitHub "Let this computer upload code to this repo."
* **Git Email:** Tells GitHub "Put this commit on this specific user's profile."

If the email on the second system doesn't match an email verified on your GitHub account, the commits will upload fine (because of the SSH key), but GitHub won't know which user profile to "link" them to. They appear as "ghost" commits by an unknown author.

---

### 2. Why does it "fix itself" when you pull?

You mentioned that once you use the repo on the **first machine**, the streak starts to appear. This is likely because:

1. You pull the changes from the second machine to the first machine.
2. You make a *new* commit or a **Merge Commit** on the first machine.
3. Because the first machine is correctly configured with your email, GitHub finally "sees" a valid contribution from you in that repository.
4. Once one valid contribution is made, GitHub often re-scans the repository and "recognizes" your authorship on the previous commits **if** the email actually matched but was just waiting for a refresh (though usually, if the email is wrong, it never counts).

---

### 3. How to fix it permanently

You need to make sure your **Git Config** on the second machine (and any future machine) matches your GitHub email.

**Run these commands on the new system:**

```bash
# Check what email is currently being used
git config user.email

# Set it to your GitHub email (the one in your GitHub Settings > Emails)
git config --global user.email "your-email@example.com"

# Set your name while you're at it
git config --global user.name "Your Name"

```

> **Note:** If you want to keep your email private, use the GitHub-provided "no-reply" email (found in your GitHub Email settings) instead of your real one.

---

### 4. How to check if past commits were wrong

Go to your repository on GitHub and click on the "Commits" list.

* **Correct:** Your profile picture appears next to the commit.
* **Incorrect:** A generic gray "identicon" or no profile link appears. This confirms the email was wrong on that machine.


# Yeah now it works once i change to matching email. but when i revert it back again other email gain the commits won't show up in bubble. but changes are accepted.

That perfectly confirms the **"Attribution vs. Permission"** logic we discussed.

Since you've verified that the email is the culprit, it's worth understanding exactly why GitHub accepts the code but "ignores" the user for the contribution graph.

---

### Why GitHub accepts "Wrong" emails

Git was designed to be decentralized. In a professional setting, a lead developer might "Push" code that was actually "Written" by someone else.

1. **The SSH Key (Permission):** This is your **Passport**. As long as the passport is valid, GitHub lets you into the building (the repository) and lets you leave your packages (the commits).
2. **The Git Email (Attribution):** This is the **Return Address** on the package.
* If the return address matches a registered GitHub user, GitHub puts a "Thank You" note on that user's profile (the green bubble).
* If the return address is a random email GitHub doesn't recognize, it still keeps the package, but it doesn't know who to thank.



---

### Can you have multiple emails?

If you want to use different emails on different machines but still want **all** your work to show up in your green streak bubbles, you don't actually have to change your local Git config every time.

**You can add multiple emails to one GitHub account:**

1. Go to **GitHub Settings > Emails**.
2. Add the "other" email you like to use.
3. Verify it.

Once verified, any commit made with that email—regardless of which machine or SSH key you use—will immediately link to your profile and fill in those green bubbles.

---

### Pro Tip: The "Secret" GitHub Email

If you don't want your real email address exposed in your public commit history (where anyone can scrape it), GitHub provides a **no-reply email address**.

* You can find it in your **Email Settings** (usually looks like `ID+username@users.noreply.github.com`).
* If you set your `git config user.email` to this address on all your machines, your bubbles will always work, and your private email stays private.

---

### How to fix those "Missing" bubbles?

If you have a bunch of commits that didn't show up in your streak because of the wrong email, you have two choices:

1. **The "Lazy" Fix:** Just add the "wrong" email to your GitHub account settings as an alias (as mentioned above). The bubbles will appear instantly for all past commits.
2. **The "Hard" Fix:** Rewrite your Git history using a script to change the email on old commits. This is generally **not recommended** if you are collaborating with others, as it changes the commit hashes and can break things for your teammates.

