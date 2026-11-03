# mydot - a personal dotfile collection

An AI-native dotfile management system built for Arch Linux, Wayland, and a terminal-first workflow. It uses GNU Stow for deployment and a declarative JSON manifest for automated discovery and agent-driven edits.

## Architecture

This utilizes GNU Stow directory folding. The core tools are:
- `mydot.py`: A custom Python orchestrator that handles discovery, staging, simulation, deployment, and restoration.
- `manifest.json`: The declarative source of truth tracking which packages and paths are active.
- `fzf`: Used interactively during discovery to stage unmapped system configurations.
- `GNU Stow`: Creates atomic OS-level symlinks without mutating the original repository files.

## Workflow

Use the management script (`mydot.py`) to migrate your dotfiles using 3 steps.

1. **Discover**
   ```bash
   ./dotmgr.py discover
   ```
Scans the host system against a known set of defaults (nvim, sway, alacritty, zsh) and uses fzf to present any remaining .config or $HOME files for interactive selection. It outputs the targets to manifest.json.


2. **Stage**
    ```bash
    ./dotmgr.py stage
    ```
Reads manifest.json and copies the specified files into the GNU Stow package structure inside the repository. It scrubs known secrets (like GitHub OAuth tokens) and generates a strict .gitignore.

3. Deploy

    ```bash
    ./dotmgr.py deploy
    ````
Backs up the existing host configurations to a timestamped archive (~/.dotfiles_backup_YYYYMMDD_HHMMSS), removes the originals, and runs stow to establish the symlinks.

5. Restore (Rollback)
    ```bash
    ./dotmgr.py restore
    ```
Tears down the Stow symlinks and recursively merges the latest backup directory back into $HOME, fully reverting the deployment.

## Agentic development

This setup enables agentic development using your favorite harness and LLMs, without ever having to leave the terminal. My preference is `aider`.
