pragma Singleton 
import Quickshell
import Quickshell.Io 
import QtQuick

Singleton {
    id: themeEngine

    // These are only fallback values! They get overwritten by the JSON.
    property color background: "#454545"
    property color foreground: "#c4c4c4"
    property color accent1: "#7aa2f7"
    property color accent2: "#b4befe"
    property color accent3: "#f5c2e7"

    // Process 1: Reads the file instantly on boot
    Process {
        id: startupReader
        command: ["cat", Quickshell.env("HOME") + "/.cache/wal/colors.json"]
        running: true
        stdout: SplitParser {
            splitMarker: "" // Read whole file at once
            onRead: (text) => themeEngine.parseRawJson(text)
        }
    }

    // Process 2: Listens for Pywal file changes using Linux inotify event loop
    Process {
        id: walWatcher
        command: ["inotifywait", "-m", "-e", "close_write", Quickshell.env("HOME") + "/.cache/wal/colors.json"]
        running: true
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: (line) => {
                // Every time pywal updates the file, tell startupReader to fetch the fresh text!
                startupReader.running = true
            }
        }
    }

    function parseRawJson(rawText) {
        if (!rawText || rawText.length === 0) return;
        try {
            let parsedData = JSON.parse(rawText.trim());
            
            // This is where the "set in stone" variables get overwritten live!
            themeEngine.background = parsedData.special.background;
            themeEngine.foreground = parsedData.special.foreground;
            
            themeEngine.accent1 = parsedData.colors.color4; 
            themeEngine.accent2 = parsedData.colors.color5; 
            themeEngine.accent3 = parsedData.colors.color6;
            
            // Console confirmation so you can verify it in your launcher terminal
            console.log("SUCCESS: Pywal scheme loaded natively! Accent1 is now:", themeEngine.accent1);
        } catch(e) {
            console.log("Error parsing Pywal JSON structure: ", e);
        }
    }
}
