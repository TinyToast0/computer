import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Io

Button {
  id: menuButton

  onClicked: menuWindow.visible = !menuWindow.visible

  background: Rectangle {
    color: parent.palette.button
  }

  palette.button: Qt.lighter(windowRoot.Theme.background, 1.5)
  palette.buttonText: windowRoot.Theme.foreground
  text: " "

  PopupWindow {
    id: menuWindow
    visible: false

    anchor {
      item: menuButton
      edges: Edges.Bottom
      margins.top: 30
    }

    grabFocus: false

    implicitWidth: 150
    implicitHeight: 100
    color: "transparent"

    Rectangle {
      anchors.fill: parent

      color: windowRoot.Theme.background
      border.color: windowRoot.Theme.accent1
      border.width: 2

      // Runner
      Button {
        background: Rectangle {
          color: Qt.lighter(parent.palette.button, 1.3)
        }
        palette.button: Qt.lighter(windowRoot.Theme.background, 1.3)
        palette.buttonText: windowRoot.Theme.foreground

        anchors {
          left: parent.left
          leftMargin: 5
          top: parent.top
          topMargin: 5
        }
        text: "Run"
        implicitWidth: 40
        implicitHeight: 25

        onClicked: {
          menuWindow.visible = !menuWindow.visible
          Quickshell.execDetached([
            "/home/toast/.config/rofi/scripts/runner.sh"
          ])
        }
      }
      // PowerMenu button
      Button {
        background: Rectangle {
          color: Qt.lighter(parent.palette.button, 1.3)
        }
        palette.button: Qt.lighter(windowRoot.Theme.background, 1.3)
        palette.buttonText: windowRoot.Theme.foreground

        anchors {
          right: parent.right
          rightMargin: 5
          bottom: parent.bottom
          bottomMargin: 5
        }
        Text {
          anchors {
            top: parent.top
            topMargin: 4
            left: parent.left
            leftMargin: 8
          }
          color: windowRoot.Theme.foreground
          text: "⏻"
        }
        implicitWidth: 25
        implicitHeight: 25

        onClicked: {
          menuWindow.visible = !menuWindow.visible
          Quickshell.execDetached([
            "/home/toast/.config/rofi/scripts/rofiPowerMenu.sh"
          ])
        }
      }
      // Kill Button
      Button {
        background: Rectangle {
          color: Qt.lighter(parent.palette.button, 1.3)
        }
        palette.button: Qt.lighter(windowRoot.Theme.background, 1.3)
        palette.buttonText: windowRoot.Theme.foreground

        anchors {
          right: parent.right
          rightMargin: 5
          top: parent.top
          topMargin: 5
        }
        Text {
          anchors {
            top: parent.top
            topMargin: 4
            left: parent.left
            leftMargin: 8
          }
          color: windowRoot.Theme.foreground
          text: "☒"
        }
        implicitWidth: 25
        implicitHeight: 25

        onClicked: {
          menuWindow.visible = !menuWindow.visible
          Quickshell.execDetached([
            "hyprctl", "kill"
          ])
        }
      }
    }
  }
}
