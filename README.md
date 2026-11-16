# 🥁 Nix Trigger

> **Zero-Latency Drum Replacement & MIDI Trigger Audio Plugin (VST3 / AU / Standalone)**  
> Built with C++17 and the JUCE 9 Framework for Windows and macOS.

[![macOS Build](https://github.com/OWNER/REPOSITORY/actions/workflows/build-mac.yml/badge.svg)](https://github.com/OWNER/REPOSITORY/actions/workflows/build-mac.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Windows & macOS](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS-informational.svg)]()
[![Format: VST3 | AU | Standalone](https://img.shields.io/badge/Format-VST3%20%7C%20AU%20%7C%20Standalone-brightgreen.svg)]()

---

## 🌟 Overview

**Nix Trigger** is an ultra-fast, sample-accurate drum replacement and audio-to-MIDI trigger plugin designed for both studio mixing and low-latency live sound. 

It analyzes live incoming drum audio (kick, snare, toms) in real-time, filters out stage rumble and cymbal bleed, and simultaneously triggers internal audio samples and outputs sample-accurate MIDI events to drive virtual drum instruments (*Superior Drummer*, *EZdrummer*, *Addictive Drums*, etc.).

---

## 🚀 Key Features

- **Sample-Accurate Transient Detection**: 1-pole High-Pass Filter $\to$ Full-Wave Rectifier $\to$ Peak Envelope Tracking $\to$ Derivative Onset Calculation ($\Delta$).
- **Anti-Bleed Intelligence**: Smart `Bleed Reject` gate and dedicated HPF (20 Hz – 500 Hz) to eliminate false triggers from hi-hat and cymbal spill.
- **Polyphonic Sampler Engine**: 8 simultaneous voices per instance. Fast rolls and flams decay naturally without abrupt voice cutting.
- **Direct MIDI Output**: Flexible MIDI Note (0–127) and Channel (1–16) routing with microsecond precision.
- **Humanize Control**: Micro-velocity randomization to prevent robotic "machine-gun" artifacts.
- **Zero Bloat & Free**: 100% royalty-free, zero background DRM, no licensing managers.
- **Universal Binary for macOS**: Native Apple Silicon (`arm64` M1/M2/M3/M4) and Intel (`x86_64`).

---

## 🎛️ Parameters

| Parameter | Range | Default | Description |
|---|---|---|---|
| **Threshold** | -60 dB to 0 dB | -20 dB | Minimum audio level to register a trigger |
| **Sensitivity** | 0.0 to 1.0 | 0.75 | Velocity curve dynamic response |
| **Retrigger** | 1 to 500 ms | 50 ms | Lockout window to prevent double hits |
| **Bleed Reject** | 0.0 to 1.0 | 0.30 | Rejects weaker bleed signals from nearby mics |
| **HPF Freq** | 20 to 500 Hz | 80 Hz | High-pass analysis filter |
| **Dry Mix** | 0.0 to 1.0 | 1.0 | Pass-through level of original drum mic |
| **Wet Mix** | 0.0 to 1.0 | 1.0 | Volume of triggered replacement sample |
| **Humanize** | 0% to 30% | 0% | Random micro-velocity variance |
| **Mode** | MIDI / Sample / Both | Both | Routing output selector |
| **MIDI Note / Ch** | 0-127 / 1-16 | 36 (C1) / 1 | Target MIDI pitch & channel |

---

## 📦 Download & Installation

### Windows (x64)
1. Download `NixTrigger-Windows-Installer.zip` from [Releases](https://github.com/OWNER/REPOSITORY/releases).
2. Extract and double-click `Install-Windows.bat` (Run as Administrator).
3. The plugin will be installed to `C:\Program Files\Common Files\VST3\`.
4. Rescan plugins in your DAW (FL Studio, Ableton Live, Reaper, Cubase, Studio One).

### macOS (Apple Silicon & Intel)
1. Download `NixTrigger-macOS-Universal.zip` or the Apple PKG installer from [Releases](https://github.com/OWNER/REPOSITORY/releases).
2. Double-click `Install-macOS.command` or run the `.pkg` installer.
3. Installs VST3 to `/Library/Audio/Plug-Ins/VST3/` and AudioUnit (AU) to `/Library/Audio/Plug-Ins/Components/`.
4. Logic Pro, GarageBand, Ableton, and Reaper will automatically discover the plugin.

---

## 🛠️ Building from Source

### Prerequisites
- CMake >= 3.22
- Visual Studio 2022/2026 (Windows) or Xcode >= 14 (macOS)
- JUCE 9.x (will be fetched automatically if not installed locally)

### Windows Build
```powershell
cmake -B build -G "Visual Studio 18 2026" -A x64
cmake --build build --config Release
```

### macOS Build
```bash
chmod +x build-mac.sh
./build-mac.sh
```

---

## 📄 User Manual
Read the complete official documentation:
- [PDF User Manual](Nix_Trigger_User_Manual.pdf)

---

## 📜 License
Distributed under the MIT License. See `LICENSE` for more information.
