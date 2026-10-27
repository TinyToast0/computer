import Quickshell
import Quickshell.Io
import QtQuick

Item {
  id: visualizerRoot

  readonly property var activeTheme: Theme
  readonly property int totalBars: 30
  readonly property int barSpacing: 2
  property var barValues: Array(totalBars).fill(0.0)

  Process {
    id: cavaProcess
    command: ["stdbuf", "-oL", "cava", "-p", Quickshell.env("HOME") + "/.config/cava/quickshell_config"]
    running: true
    stdout: SplitParser {
      splitMarker: "\n"
      onRead: (line) => {
        let trimmed = line.trim();
        if (trimmed.length === 0) return;
        let values = trimmed.split(";"); 
        if (values.length <= 1) values = trimmed.split(/\s+/);
        let rightValues = [];
        for (let i = 0; i < visualizerRoot.totalBars; i++) {
          let val = parseInt(values[i + 30]) || 0;
          rightValues.push(val / 100.0);
        }
        visualizerRoot.barValues = rightValues;
      }
    }
  }
  Row {
    anchors.fill: parent
    anchors.bottom: parent.bottom
    spacing: visualizerRoot.barSpacing
    x: 0
    Repeater {
      model: visualizerRoot.totalBars
      delegate: Rectangle {
        width: Math.floor((visualizerRoot.width - (visualizerRoot.barSpacing * (visualizerRoot.totalBars - 1))) / visualizerRoot.totalBars)
        height: Math.max(2, (visualizerRoot.height * visualizerRoot.barValues[index]) * 0.85)
        y: visualizerRoot.height - height
        radius: 0
        gradient: Gradient {
          GradientStop { position: 0.0; color: Theme.accent1 } 
          GradientStop { position: 0.7; color: Theme.accent2 } 
          GradientStop { position: 1.0; color: Theme.accent3 } 
        }
        opacity: visualizerRoot.barValues[index] > 0.05 ? 0.9 : 0.3
        Behavior on height { NumberAnimation { duration: 65; easing.type: Easing.OutCubic } }
      }
    }
  }
}
