import QtQuick
import QtQuick.Layouts
import "../config.js" as Config
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io


PanelWindow {
  anchors {
    top: false
    bottom: true
    left: true
    right: true
  }
  height: 40
  color: Colors.special.background

  WrapperItem {
    anchors.centerIn: parent
  Rectangle {
    width: 70
    height: 35
    color: Colors.colors.color1
    Text {
      id: clock
      color: Colors.special.background
      font.pixelSize: 14

      // Set an initial update when the widget loads
      Component.onCompleted: {
        clock.text = Qt.formatDateTime(new Date(), "hh:mm:ss");
      }

      Timer {
        interval: 1000 // Updates every 1 second
        running: true
        repeat: true
        onTriggered: {
          clock.text = Qt.formatDateTime(new Date(), "hh:mm:ss");
        }
      }
    }
  }
  }
  Rectangle {
    id: distro
    anchors.centerIn: parent
    width: 50
    height: 35
    color: Colors.colors.color1

    WrapperItem {
      id: distroIcon
      leftMargin: 13
      topMargin: -5
      Text {
        font.pixelSize: 29
        text: "󰣇"
      }
    }
  }
}
