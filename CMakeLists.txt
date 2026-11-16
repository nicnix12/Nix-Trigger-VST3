cmake_minimum_required(VERSION 3.22)
project(NixTrigger VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ============================================================
# Platform configuration (macOS vs Windows)
# ============================================================
if (APPLE)
    # Target Universal Binary (Apple Silicon M1/M2/M3/M4 + Intel x86_64)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.13" CACHE STRING "Minimum macOS version" FORCE)
    
    # Format untuk macOS: VST3 + AudioUnit (AU/component) + Standalone App
    set(NIX_PLUGIN_FORMATS VST3 AU Standalone)
    message(STATUS "Configuring NixTrigger for macOS (Universal: arm64 + x86_64, Formats: VST3, AU, Standalone)")
else()
    # Format untuk Windows: VST3 + Standalone .exe
    set(NIX_PLUGIN_FORMATS VST3 Standalone)
    message(STATUS "Configuring NixTrigger for Windows (Formats: VST3, Standalone)")
endif()

# ============================================================
# JUCE 9.x Setup (Local or FetchContent)
# ============================================================
if (EXISTS "C:/JUCE/CMakeLists.txt")
    add_subdirectory("C:/JUCE" JUCE)
elseif (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../JUCE/CMakeLists.txt")
    add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../JUCE" JUCE)
else()
    include(FetchContent)
    FetchContent_Declare(
        JUCE
        GIT_REPOSITORY https://github.com/juce-framework/JUCE.git
        GIT_TAG        9.0.5
    )
    FetchContent_MakeAvailable(JUCE)
endif()

# ============================================================
# Plugin target
# ============================================================
juce_add_plugin(NixTrigger
    COMPANY_NAME             "NixAudio"
    PLUGIN_MANUFACTURER_CODE NxAu
    PLUGIN_CODE              NxTr
    FORMATS                  ${NIX_PLUGIN_FORMATS}
    PRODUCT_NAME             "Nix Trigger"
    BUNDLE_ID                "com.nixaudio.nixtrigger"
    IS_SYNTH                 FALSE
    NEEDS_MIDI_INPUT         FALSE
    NEEDS_MIDI_OUTPUT        TRUE
    IS_MIDI_EFFECT           FALSE
    EDITOR_WANTS_KEYBOARD_FOCUS FALSE
    COPY_PLUGIN_AFTER_BUILD  FALSE
    VST3_CATEGORIES          "Fx"
    AU_MAIN_TYPE             kAudioUnitType_MusicEffect
)

# ============================================================
# Include directories
# ============================================================
target_include_directories(NixTrigger
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/Source
)

# ============================================================
# Sources
# ============================================================
target_sources(NixTrigger
    PRIVATE
        Source/PluginProcessor.cpp
        Source/PluginProcessor.h
        Source/PluginEditor.cpp
        Source/PluginEditor.h
        Source/Core/PluginParameters.h
        Source/Core/TriggersCommon.h
        Source/DSP/TransientDetector.h
        Source/Sampler/SampleVoice.h
        Source/Sampler/DrumSamplerEngine.h
        Source/UI/TriggerMeterComponent.h
        Source/UI/NixLookAndFeel.h
)

# ============================================================
# Compile definitions
# ============================================================
target_compile_definitions(NixTrigger
    PUBLIC
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_VST3_CAN_REPLACE_VST2=0
        JUCE_DISPLAY_SPLASH_SCREEN=0
)

# ============================================================
# Link libraries
# ============================================================
target_link_libraries(NixTrigger
    PRIVATE
        juce::juce_audio_basics
        juce::juce_audio_devices
        juce::juce_audio_formats
        juce::juce_audio_plugin_client
        juce::juce_audio_processors
        juce::juce_audio_utils
        juce::juce_core
        juce::juce_data_structures
        juce::juce_events
        juce::juce_graphics
        juce::juce_gui_basics
        juce::juce_gui_extra
        juce::juce_dsp
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_warning_flags
)
