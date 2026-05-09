# ArchSetup 🚀

A minimalistic, official approach to setting up your dream Arch Linux environment with KDE Plasma and modern Rust-based tools.

## Usage

### 1. Boot Arch ISO
Boot into your live Arch environment and ensure you have internet access.

### 2. Run the Installer
Run the official `archinstall` pointing to your custom config:
```bash
archinstall --config tinyurl.com/nilarch
```

### 3. Run Post-Install Script
Once you've booted into your new system, run the customization script to apply themes and extra tools:
```bash
curl -sL tinyurl.com/kaamsesh | bash
```

## What it sets up:
- **Kernel:** `linux-zen` + `systemd-boot`
- **Desktop:** KDE Plasma (RocketUI Minimalist Black theme)
- **Shell:** Fish (with abbreviations for Rust tools like eza, bat, fd)
- **Performance:** ALHP repos, Profile-sync-daemon, systemd-oomd, zRAM.
- **Tools:** Rustup, micro, paru, topgrade, helium-browser, spotify, and more.
