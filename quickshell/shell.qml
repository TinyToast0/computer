import Quickshell
import Quickshell.Io
import QtQuick
import "modules"
import "config.js" as Config

Scope {
  FileView {
    id: walFile

    path: "/home/toast/.cache/wal/colors.json"
    watchChanges: true
    blockLoading: true

    function reloadColors() {
      try {
        Colors.setColors(JSON.parse(text()));
      } catch (e) {
        console.log("wal parse failed:", e);
      }
    }

    onLoaded: reloadColors()

    onFileChanged: reload()

    onTextChanged: reloadColors()
  }
  Bar {
    id: bar
  }
}
