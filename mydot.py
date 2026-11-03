#!/usr/bin/env python3

import json
import os
import shutil
import subprocess
from datetime import datetime
from pathlib import Path
import argparse

DOT_DIR = Path.home() / "dev" / "mydot"
MANIFEST_FILE = DOT_DIR / "manifest.json"

CORE_DEFAULTS = ["nvim", "sway", "alacritty", "mako", "gh"]

def get_rel_path(path: Path) -> Path:
    return path.relative_to(Path.home())

def run_fzf(candidates: list[str]) -> list[str]:
    if not shutil.which("fzf"):
        print("fzf not found. Skipping interactive discovery.")
        return []

    process = subprocess.run(
        ["fzf", "-m", "--prompt=Select dotfiles > ", "--header=Discovered Configs (TAB to select)"],
        input="\n".join(candidates),
        text=True,
        capture_output=True
    )
    return [line for line in process.stdout.split("\n") if line]

def discover():
    print("Step 1: Autodiscovering dotfiles...")
    manifest = {}

    def add_to_manifest(pkg: str, path: Path):
        if path.exists():
            manifest.setdefault(pkg, []).append(str(path))

    for conf in CORE_DEFAULTS:
        add_to_manifest(conf, Path.home() / ".config" / conf)

    add_to_manifest("zsh", Path.home() / ".zshrc")
    add_to_manifest("zsh", Path.home() / ".zprofile")

    for f in [".tmux.conf", ".gitconfig", ".gitignore"]:
        pkg = "git" if "git" in f else "core"
        add_to_manifest(pkg, Path.home() / f)

    add_to_manifest("git", Path.home() / "work_repos" / ".gitconfig")
    add_to_manifest("git", Path.home() / "dev" / ".gitconfig")

    omz_custom = Path.home() / ".oh-my-zsh" / "custom"
    if omz_custom.exists():
        for zsh_file in omz_custom.glob("*.zsh"):
            add_to_manifest("zsh", zsh_file)

    config_dir = Path.home() / ".config"
    config_cands = []
    if config_dir.exists():
        ignores = {"chromium", "google-chrome", "dconf", "pulse", "slack", "zoom", "obs-studio", "Electron", "systemd", "pamac", "VirtualBox", "obsidian"}
        config_cands = [
            f".config/{d.name}" for d in config_dir.iterdir()
            if d.is_dir() and d.name not in ignores and not d.name.startswith("Code") and not d.name.startswith("cef_") and d.name not in CORE_DEFAULTS
        ]

    home_cands = [
        f.name for f in Path.home().iterdir()
        if f.is_file() and f.name.startswith(".") and f.name not in {".zshrc", ".zprofile", ".tmux.conf", ".gitconfig", ".gitignore"}
        and f.suffix in {".profile", ".bashrc", ".bash_profile", ".xinitrc"}
    ]

    selected = run_fzf(config_cands + home_cands)
    for item in selected:
        if item.startswith(".config/"):
            pkg = item.replace(".config/", "")
            add_to_manifest(pkg, Path.home() / item)
        else:
            add_to_manifest("core", Path.home() / item)

    DOT_DIR.mkdir(parents=True, exist_ok=True)
    with open(MANIFEST_FILE, "w") as f:
        json.dump(manifest, f, indent=4)

    print(f"Discovery complete! Review your manifest at: {MANIFEST_FILE}")

def stage():
    print("Step 2: Staging files into repository...")
    if not MANIFEST_FILE.exists():
        print(f"Error: {MANIFEST_FILE} not found. Run discover first.")
        return

    with open(MANIFEST_FILE, "r") as f:
        manifest = json.load(f)

    def safe_stage_copy(src: Path, dest: Path):
        if src.is_symlink():
            return

        if src.is_dir():
            dest.mkdir(parents=True, exist_ok=True)
            for item in src.iterdir():
                safe_stage_copy(item, dest / item.name)
        else:
            if src.exists() and dest.exists() and src.samefile(dest):
                return
            shutil.copy2(src, dest)

    for pkg, paths in manifest.items():
        for path_str in paths:
            orig = Path(path_str)
            if orig.exists():
                rel_path = get_rel_path(orig)
                target_dir = DOT_DIR / pkg / rel_path.parent
                target_dir.mkdir(parents=True, exist_ok=True)

                target_path = DOT_DIR / pkg / rel_path
                safe_stage_copy(orig, target_path)
                print(f" -> Staged {orig} into {pkg}")

    hosts_yml = DOT_DIR / "gh" / ".config" / "gh" / "hosts.yml"
    if hosts_yml.exists():
        hosts_yml.unlink()
        print(" -> Scrubbed GitHub OAuth token (hosts.yml)")

    gitignore_content = """# Secrets and OS generated
hosts.yml
*.key
*.pem
id_rsa*
.netrc
.env
.DS_Store
.stow-local-ignore
"""
    (DOT_DIR / ".gitignore").write_text(gitignore_content)
    print("Staging complete! Review your files before deploying.")

def simulate():
    print("Simulating deployment via Stow (Dry Run)...")
    if not MANIFEST_FILE.exists():
        print(f"Error: {MANIFEST_FILE} not found. Run stage first.")
        return

    with open(MANIFEST_FILE, "r") as f:
        manifest = json.load(f)

    print("\nNote: Stow may report 'conflicts' for files that currently exist in your home directory.")
    print("During an actual 'deploy', our script automatically backs up and removes these original files first.\n")

    os.chdir(DOT_DIR)
    for pkg in manifest.keys():
        print(f"--- Simulating package: {pkg} ---")
        # -n/--simulate paired with -v/--verbose to print intended actions
        subprocess.run(["stow", "--simulate", "--verbose", "--target", str(Path.home()), pkg])

def deploy():
    print("Step 3: Deploying symlinks via Stow...")
    if not MANIFEST_FILE.exists():
        print("Error: Manifest not found.")
        return

    backup_dir = Path.home() / f".dotfiles_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
    confirm = input(f"WARNING: This will backup original files to {backup_dir} and stow the repo. Proceed? [y/N]: ")
    if confirm.lower() != 'y':
        print("Deployment aborted.")
        return

    with open(MANIFEST_FILE, "r") as f:
        manifest = json.load(f)

    backup_dir.mkdir(parents=True, exist_ok=True)

    for pkg, paths in manifest.items():
        for path_str in paths:
            orig = Path(path_str)
            if orig.exists() and not orig.is_symlink():
                rel_path = get_rel_path(orig)
                backup_target_dir = backup_dir / rel_path.parent
                backup_target_dir.mkdir(parents=True, exist_ok=True)

                if orig == Path.home() / ".config" / "gh":
                    gh_backup = backup_dir / ".config" / "gh"
                    gh_backup.mkdir(parents=True, exist_ok=True)
                    for child in orig.iterdir():
                        if child.name != "hosts.yml":
                            shutil.move(str(child), str(gh_backup / child.name))
                else:
                    shutil.move(str(orig), str(backup_dir / rel_path))
                print(f" -> Backed up {orig}")

    os.chdir(DOT_DIR)
    for pkg in manifest.keys():
        subprocess.run(["stow", "--target", str(Path.home()), pkg])
        print(f" -> Linked package: {pkg}")

    print("Deployment complete! Your system is now running on Stow symlinks.")

def restore():
    print("Reverting deployment and restoring from latest backup...")

    backups = sorted([d for d in Path.home().glob(".dotfiles_backup_*") if d.is_dir()])
    if not backups:
        print("Error: No backup directories found in your home folder.")
        return

    latest_backup = backups[-1]

    confirm = input(f"WARNING: This will delete Stow symlinks and restore files from {latest_backup}. Proceed? [y/N]: ")
    if confirm.lower() != 'y':
        print("Restore aborted.")
        return

    if MANIFEST_FILE.exists():
        with open(MANIFEST_FILE, "r") as f:
            manifest = json.load(f)

        os.chdir(DOT_DIR)
        for pkg in manifest.keys():
            subprocess.run(["stow", "-D", "--target", str(Path.home()), pkg])
            print(f" -> Removed symlinks for package: {pkg}")
    else:
        print("Manifest not found, skipping unstow (assuming symlinks are already gone).")

    def recursive_restore(src: Path, dest: Path):
        for item in src.iterdir():
            target = dest / item.name
            if item.is_dir():
                target.mkdir(parents=True, exist_ok=True)
                recursive_restore(item, target)
            else:
                if target.exists() or target.is_symlink():
                    target.unlink()
                shutil.move(str(item), str(target))
                print(f" -> Restored: {target}")

    print("Restoring original files...")
    recursive_restore(latest_backup, Path.home())

    shutil.rmtree(latest_backup)
    print("Restore complete! Your system has been reverted to its original state.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="AI-native Dotfile Manager")
    parser.add_argument("action", choices=["discover", "stage", "simulate", "deploy", "restore"], help="Action to perform")
    args = parser.parse_args()

    if args.action == "discover": discover()
    elif args.action == "stage": stage()
    elif args.action == "simulate": simulate()
    elif args.action == "deploy": deploy()
    elif args.action == "restore": restore()
