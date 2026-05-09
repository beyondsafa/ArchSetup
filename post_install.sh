#!/bin/bash
set -e

echo "🚀 Starting RocketUI Post-Install Customization..."

# 1. Enable multilib
echo "🔧 Enabling multilib..."
sudo sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf
sudo pacman -Sy --noconfirm

# 2. Setup Rust
echo "🦀 Setting up Rust stable..."
rustup default stable

# 3. Bootstrap AUR Helper (yay-bin)
echo "📦 Bootstrapping yay-bin..."
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd -
fi

# 4. Install AUR packages
echo "📦 Installing AUR tools and themes..."
aur_pkgs=(
    "paru" "topgrade" "pfetch-rs" "cloudflare-warp-bin" 
    "nextdns" "helium-browser-bin" "pamac-aur"
    "sweet-cursor-theme-git" "fluent-icon-theme-git"
)
yay -S --noconfirm "${aur_pkgs[@]}"

# 5. Paru Sane Configuration
echo "⚙️ Configuring paru..."
paru_conf="[options]
PgpFetch
Devel
Provides
CombinedUpgrade
BatchInstall
SudoLoop
BottomUp"
echo -e "$paru_conf" | sudo tee /etc/paru.conf > /dev/null

# 6. ALHP Repos (High Priority)
echo "⚡ Prioritizing ALHP repos..."
LEVEL=$(/lib/ld-linux-x86-64.so.2 --help | grep -E "x86-64-v[2-4] (supported, searched|supported)" | tail -n 1 | awk '{print $1}')
if [ ! -z "$LEVEL" ]; then
    echo "Detected CPU Level: $LEVEL"
    sudo sed -i "1i [core-$LEVEL]\nInclude = /etc/pacman.d/alhp-mirrorlist\n\n[extra-$LEVEL]\nInclude = /etc/pacman.d/alhp-mirrorlist\n" /etc/pacman.conf
fi

# 7. Chaotic-AUR (Available but disabled)
echo "🌀 Adding Chaotic-AUR placeholder..."
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "\n#[chaotic-aur]\n#Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf > /dev/null
fi

# 8. Fish Shell Global Configuration
echo "🐟 Configuring Fish shell..."
fish_conf="set -g fish_greeting \"\"
abbr -a ls \"eza --icons\"
abbr -a cat \"bat\"
abbr -a grep \"rg\"
abbr -a find \"fd\"
abbr -a du \"dust\"
zoxide init fish | source
fastfetch"
sudo mkdir -p /etc/fish/conf.d
echo -e "$fish_conf" | sudo tee /etc/fish/conf.d/rocketui.fish > /dev/null

# 9. Wallpaper Branding
echo "🌌 Downloading Space Wallpaper..."
sudo mkdir -p /usr/share/backgrounds/rocketui
sudo curl -L https://w.wallhaven.cc/full/85/wallhaven-85m89y.jpg -o /usr/share/backgrounds/rocketui/space.jpg
sudo mkdir -p /etc/xdg
echo -e "[Wallpaper]\nImage=file:///usr/share/backgrounds/rocketui/space.jpg" | sudo tee /etc/xdg/plasmarc > /dev/null

# 10. RocketUI Color Scheme
echo "🎨 Applying RocketUI Color Scheme..."
sudo mkdir -p /usr/share/color-schemes
cat <<EOF | sudo tee /usr/share/color-schemes/RocketUI.colors > /dev/null
[ColorEffects:Disabled]
Color=36,36,36
ColorAmount=0.5
ColorEffect=3
ContrastAmount=0.5
ContrastEffect=0
IntensityAmount=0
IntensityEffect=0

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=10,10,10
ColorAmount=0.4
ColorEffect=3
ContrastAmount=0.4
ContrastEffect=0
Enable=true
IntensityAmount=-0.2
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=34,34,34
BackgroundNormal=0,0,0
DecorationFocus=52,120,218
DecorationHover=0,161,236
ForegroundActive=61,174,233
ForegroundInactive=199,199,199
ForegroundLink=0,100,255
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=241,241,241
ForegroundPositive=36,173,89
ForegroundVisited=115,115,158

[Colors:Complementary]
BackgroundAlternate=59,64,69
BackgroundNormal=49,54,59
DecorationFocus=30,146,255
DecorationHover=61,174,230
ForegroundActive=246,116,0
ForegroundInactive=175,176,179
ForegroundLink=61,174,230
ForegroundNegative=237,21,21
ForegroundNeutral=201,206,59
ForegroundNormal=239,240,241
ForegroundPositive=17,209,22
ForegroundVisited=61,174,230

[Colors:Selection]
BackgroundAlternate=29,153,243
BackgroundNormal=27,145,213
DecorationFocus=52,120,218
DecorationHover=0,161,236
ForegroundActive=252,252,252
ForegroundInactive=241,241,241
ForegroundLink=0,100,255
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=241,241,241
ForegroundPositive=36,173,89
ForegroundVisited=115,115,158

[Colors:Tooltip]
BackgroundAlternate=77,77,77
BackgroundNormal=0,0,0
DecorationFocus=52,120,218
DecorationHover=0,161,236
ForegroundActive=61,174,233
ForegroundInactive=199,199,199
ForegroundLink=0,100,255
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=36,173,89
ForegroundVisited=115,115,158

[Colors:View]
BackgroundAlternate=34,34,34
BackgroundNormal=5,5,5
DecorationFocus=52,120,218
DecorationHover=0,161,236
ForegroundActive=61,174,233
ForegroundInactive=199,199,199
ForegroundLink=0,100,255
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=241,241,241
ForegroundPositive=36,173,89
ForegroundVisited=115,115,158

[Colors:Window]
BackgroundAlternate=34,34,34
BackgroundNormal=1,1,1
DecorationFocus=52,120,218
DecorationHover=0,161,236
ForegroundActive=61,174,233
ForegroundInactive=199,199,199
ForegroundLink=0,100,255
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=36,173,89
ForegroundVisited=115,115,158

[General]
ColorScheme=Black
Name=RocketUI
shadeSortColumn=true

[KDE]
contrast=0

[WM]
activeBackground=0,0,0
activeBlend=255,255,255
activeForeground=239,240,241
inactiveBackground=10,10,10
inactiveBlend=3,3,3
inactiveForeground=144,144,144
EOF

echo "✨ All done! Please restart your session to see the changes."
