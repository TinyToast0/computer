import Quickshell
import QtQuick

Scope {
  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        id: windowRoot
        required property var modelData
        screen: modelData

        readonly property var activeTheme: Theme

        readonly property int startWorkspace: modelData.name === "DP-2" ? 6 : 1
        readonly property int workspaceCount: 5

        anchors {
          top: true
          left: true
          right: true
        }
        implicitHeight: 31
        color: activeTheme.background

        // Audio
        Audio {
          anchors.right: rightBox.left
          anchors.rightMargin: 30
          anchors.top: parent.top
          anchors.topMargin: 3
        }

        // This is the Item id: mainAudio file
        AudioChange {
          x: 874
        }

        // Menu
        Menu {
          id: menuWidget
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.rightMargin: 3
          width: 25
          height: 25

        }

        // Workspaces
        Rectangle {
          id: leftBox
          anchors.left: parent.left
          anchors.leftMargin: 3
          anchors.verticalCenter: parent.verticalCenter
          height: 25
          width: 129
          color: Qt.lighter(windowRoot.activeTheme.background, 1.75)
          
          Workspaces {}
        }

        // Clock
        Rectangle {
          id: rightBox
          anchors.right: menuWidget.left
          anchors.rightMargin: 3
          anchors.verticalCenter: parent.verticalCenter
          color: Qt.lighter(windowRoot.activeTheme.background, 1.5)
          width: 120
          height: 25

          ClockWidget {
            anchors.centerIn: parent
            color: windowRoot.activeTheme.foreground
            font.pixelSize: 15
          }
        }

        // Mpris
        Mpris {
          id: centerPlayer
          anchors.centerIn: parent
        }

        // Left Side Visualizer
        VisualizerLeft {
          anchors.left: leftBox.right
          anchors.right: centerPlayer.left
          anchors.leftMargin: 10
          anchors.rightMargin: 10 // Reset to 10
          anchors.verticalCenter: parent.verticalCenter
          height: 25
        }

        // Right Side Visualizer
        VisualizerRight {
          anchors.left: centerPlayer.right
          anchors.right: rightBox.left
          anchors.leftMargin: 10 // Reset to 10
          anchors.rightMargin: 10
          anchors.verticalCenter: parent.verticalCenter
          height: 25
        }
      }
    }
  }
}
