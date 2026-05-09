# ArchSetup 🚀

A minimalistic, official approach to setting up your dream Arch Linux environment with KDE Plasma and modern Rust-based tools.

## Usage

### 1. Boot Arch ISO
Boot into your live Arch environment and ensure you have internet access.

### 2. Run the Installer
Run the official `archinstall` pointing to this configuration:
```bash
archinstall --config https://raw.githubusercontent.com/beyondsafa/ArchSetup/master/archinstall_config.json
```
*Note: You will still be prompted for passwords and disk partitioning if not fully defined in the JSON.*

### 3. Run Post-Install Script
Once you've booted into your new system, run the customization script:
```bash
curl -sL https://raw.githubusercontent.com/beyondsafa/ArchSetup/master/post_install.sh | bash
```

## What it sets up:
- **Desktop:** KDE Plasma (Minimalist Black theme)
- **Shell:** Fish (with abbreviations for Rust tools)
- **Performance:** ALHP repos (prioritized), Profile-sync-daemon, systemd-oomd.
- **AUR:** yay, paru, pamac, and various themes/tools.
- **Apps:** qBittorrent, Spotify, Android Tools, rclone, and more.
