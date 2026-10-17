# 🖥️ Terminal Everything Linux (TEL)

A curated collection, umbrella meta-repository, and unified manager for terminal-first, headless, and keyboard-driven applications on Linux.

> **Philosophy**: Replace heavy Electron, Qt, and Chromium-based graphical frontends with lightweight, instantaneous terminal tools, headless background services, and keyboard-centric workflows without sacrificing native system capabilities.

---

## 📦 Included Tools

| Tool | Category | Status | Location / Submodule | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Steam TUI** | 🎮 Gaming | `Stable` | [jJohn313/steam-tui](https://github.com/jJohn313/steam-tui) | Headless Steam launcher, library browser, and live HUD with **0 MB lightweight shim**, automatic anti-cheat classification, in-flight update tracking, and full bidirectional cloud save sharing. |
| **YouTube in Terminal** | 📺 Media / Video | `WIP` | [jJohn313/youtube-tui](https://github.com/jJohn313/youtube-tui) | Terminal YouTube search and streaming client with inline Kitty/Chafa thumbnail art and deduplicated, hardware-accelerated MPV playback. |
| **Webflow** | 🌐 Web / Browser | `WIP` | [jJohn313/webflow](https://github.com/jJohn313/webflow) | Non-Chromium, modular web architecture: terminal Markdown extractor (`wf-reader`) & chromeless WebKitGTK modal viewer (`wf-view`) with Vim bindings & `f`-hints. |

---

## ⚡ Quickstart

### 1. Clone with Submodules
```bash
git clone --recurse-submodules https://github.com/jJohn313/terminal-everything-linux.git
cd terminal-everything-linux
```

### 2. Install & Link to Path
Run the unified installer to initialize any missing submodules and symlink executables directly into `~/.local/bin`:
```bash
./install.sh
```

### 3. Verify Status
```bash
./install.sh --status
```

---

## 🛠️ Management CLI (`install.sh`)

| Command | Action |
| :--- | :--- |
| `./install.sh` / `./install.sh --install` | Initializes submodules and symlinks binaries into `~/.local/bin`. |
| `./install.sh --update` | Pulls the latest commits from all upstream tool submodules. |
| `./install.sh --status` | Inspects current symlinks and reporting target status. |
| `./install.sh --uninstall` | Cleanly removes TEL symlinks from `~/.local/bin`. |

---

## ➕ Adding a New Tool

To integrate a new terminal-first tool into the collection:

```bash
# Add as a git submodule in tools/
git submodule add <git-repo-url> tools/<tool-name>

# Commit the submodule addition
git commit -m "feat: add <tool-name> to collection"
```

Then update `install.sh` to symlink its binary to `~/.local/bin`.

---

## 📄 License

MIT License. Individual submodules retain their respective upstream licenses.
