# Nix Trigger — Build & Installer Guide

## 📄 User Manual Resmi (PDF)
Dokumen panduan pengguna lengkap dalam format PDF telah disertakan di root project:
- **File PDF:** [`Nix_Trigger_User_Manual.pdf`](file:///C:/Users/Nikodemus%20Kurniawan/.gemini/antigravity/scratch/NixTrigger/Nix_Trigger_User_Manual.pdf)

---

## 📦 Paket Installer Siap Pakai

### 🪟 Windows
Paket installer Windows lengkap sudah dibuat:
- **File ZIP:** [`NixTrigger-Windows-Installer.zip`](file:///C:/Users/Nikodemus%20Kurniawan/.gemini/antigravity/scratch/NixTrigger/NixTrigger-Windows-Installer.zip)
- **Folder Distribusi:** [`Dist-Windows`](file:///C:/Users/Nikodemus%20Kurniawan/.gemini/antigravity/scratch/NixTrigger/Dist-Windows)

**Cara Install di Windows:**
1. Ekstrak file zip (atau buka folder `Dist-Windows`).
2. Double-click **`Install-Windows.bat`** (atau klik kanan → *Run as administrator*).
3. Installer akan otomatis memasang VST3 ke folder sistem, memasang Standalone App ke Program Files, dan membuat shortcut di Start Menu.
4. Buka DAW Anda dan lakukan *Rescan Plugins*.

---

### 🍏 macOS
File installer untuk macOS tersedia di folder [`Installers/macOS/`](file:///C:/Users/Nikodemus%20Kurniawan/.gemini/antigravity/scratch/NixTrigger/Installers/macOS):
1. **`Install-macOS.command`**: Script 1-klik yang bisa di-*double-click* langsung di Finder macOS.
   - Otomatis memasang VST3, AudioUnit (AU), dan Standalone App ke direktori sistem.
   - Otomatis melepaskan proteksi Gatekeeper (`xattr -cr`).
   - Me-refresh cache AudioUnit macOS agar Logic Pro langsung mendeteksi tanpa reboot.
2. **`create-pkg-installer.sh`**: Membuat file instalasi resmi Apple `.pkg` (**`NixTrigger-macOS-Installer.pkg`**).
3. **`Uninstall-macOS.command`**: Script 1-klik untuk menghapus plugin dari Mac.

---

## Panduan Build untuk macOS

Binary sudah selesai dikompilasi dalam mode **Release (x64)** dan siap digunakan:

1. **VST3 Plugin**:
   `C:\Users\Nikodemus Kurniawan\.gemini\antigravity\scratch\NixTrigger\build\NixTrigger_artefacts\Release\VST3\Nix Trigger.vst3`

2. **Standalone App (.exe)** (Bisa dijalankan langsung tanpa DAW):
   `C:\Users\Nikodemus Kurniawan\.gemini\antigravity\scratch\NixTrigger\build\NixTrigger_artefacts\Release\Standalone\Nix Trigger.exe`

---

## Panduan Build untuk macOS (Apple Silicon M1/M2/M3/M4 & Intel)

Project ini telah dikonfigurasi penuh untuk macOS dengan dukungan:
- **Format:** VST3 (`.vst3`), AudioUnit/AU (`.component`), Standalone App (`.app`)
- **Arsitektur:** Universal Binary (`arm64` + `x86_64`)
- **Bundle Identifier:** `com.nixaudio.nixtrigger`

### Cara 1: Menggunakan Script Otomatis (di macOS)
Jalankan di Terminal Mac Anda:
```bash
chmod +x build-mac.sh
./build-mac.sh
```

### Cara 2: Manual via CMake
```bash
cmake -B build-mac \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="10.13"

cmake --build build-mac --config Release --parallel
```

### Cara 3: Otomatis via GitHub Actions (Cloud Build Gratis)
File workflow telah disiapkan di `.github/workflows/build-mac.yml`. 
Cukup push project ini ke repository GitHub Anda:
1. GitHub Actions akan otomatis compile di runner macOS terbaru (`macos-latest`).
2. Download file zip hasil build langsung dari tab **Actions** → **Artifacts** (`NixTrigger-macOS-Universal.zip`).

---

## Cara Install di macOS

Salin file hasil build ke direktori plugin sistem Mac:

```bash
# 1. Install VST3
sudo cp -R "build-mac/NixTrigger_artefacts/Release/VST3/Nix Trigger.vst3" /Library/Audio/Plug-Ins/VST3/

# 2. Install AudioUnit (AU / Component) untuk Logic Pro / GarageBand
sudo cp -R "build-mac/NixTrigger_artefacts/Release/AU/Nix Trigger.component" /Library/Audio/Plug-Ins/Components/

# 3. Lepas blokir Gatekeeper (karena build sendiri / self-signed)
sudo xattr -cr "/Library/Audio/Plug-Ins/VST3/Nix Trigger.vst3"
sudo xattr -cr "/Library/Audio/Plug-Ins/Components/Nix Trigger.component"
```

Buka DAW (Logic Pro, Ableton, FL Studio Mac, Reaper, dll.) dan plugin siap digunakan!

Salin folder `Nix Trigger.vst3` ke folder VST3 sistem Windows:
```powershell
Copy-Item -Recurse -Force "C:\Users\Nikodemus Kurniawan\.gemini\antigravity\scratch\NixTrigger\build\NixTrigger_artefacts\Release\VST3\Nix Trigger.vst3" "C:\Program Files\Common Files\VST3\"
```
*(Buka PowerShell sebagai Administrator jika diminta izin akses)*.

Lalu buka DAW Anda (FL Studio, Ableton Live, Reaper, Cubase, Studio One, dll.) dan lakukan **Rescan VST Plugins**.

---

## Cara Re-build (Jika ada perubahan kode)

Gunakan perintah satu baris berikut:

```powershell
cd "C:\Users\Nikodemus Kurniawan\.gemini\antigravity\scratch\NixTrigger"
& "C:\Program Files\CMake\bin\cmake.exe" --build build --config Release
```
