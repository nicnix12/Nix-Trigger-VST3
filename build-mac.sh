#!/bin/bash
set -e

echo "=================================================="
echo " Building Nix Trigger for macOS (Universal Binary)"
echo " Formats: VST3, AudioUnit (AU), Standalone App"
echo " Architectures: Apple Silicon (arm64) + Intel (x86_64)"
echo "=================================================="

# Bersihkan build lama jika ada
rm -rf build-mac

# Configure CMake
cmake -B build-mac \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="10.13"

# Build all formats
cmake --build build-mac --config Release --parallel $(sysctl -n hw.ncpu)

echo ""
echo "=== Signing Binaries (Ad-Hoc to avoid Gatekeeper block) ==="
if [ -d "build-mac/NixTrigger_artefacts/Release/VST3/Nix Trigger.vst3" ]; then
    codesign --force --deep -s - "build-mac/NixTrigger_artefacts/Release/VST3/Nix Trigger.vst3"
fi
if [ -d "build-mac/NixTrigger_artefacts/Release/AU/Nix Trigger.component" ]; then
    codesign --force --deep -s - "build-mac/NixTrigger_artefacts/Release/AU/Nix Trigger.component"
fi
if [ -d "build-mac/NixTrigger_artefacts/Release/Standalone/Nix Trigger.app" ]; then
    codesign --force --deep -s - "build-mac/NixTrigger_artefacts/Release/Standalone/Nix Trigger.app"
fi

echo ""
echo "=================================================="
echo " Build Selesai!"
echo " Lokasi hasil kompilasi:"
echo " - VST3:       build-mac/NixTrigger_artefacts/Release/VST3/Nix Trigger.vst3"
echo " - AudioUnit:  build-mac/NixTrigger_artefacts/Release/AU/Nix Trigger.component"
echo " - Standalone: build-mac/NixTrigger_artefacts/Release/Standalone/Nix Trigger.app"
echo "=================================================="
echo ""
echo "Untuk install ke Mac Anda:"
echo "  sudo cp -R 'build-mac/NixTrigger_artefacts/Release/VST3/Nix Trigger.vst3' /Library/Audio/Plug-Ins/VST3/"
echo "  sudo cp -R 'build-mac/NixTrigger_artefacts/Release/AU/Nix Trigger.component' /Library/Audio/Plug-Ins/Components/"
echo "  sudo xattr -cr '/Library/Audio/Plug-Ins/VST3/Nix Trigger.vst3'"
echo "  sudo xattr -cr '/Library/Audio/Plug-Ins/Components/Nix Trigger.component'"
