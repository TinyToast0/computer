import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

RowLayout {
  anchors.fill: parent
  anchors.leftMargin: 4

  Repeater {
  model: windowRoot.workspaceCount

    delegate: Rectangle {
      color: windowRoot.Theme.accent1
      implicitWidth: Math.max(20, workspaceText.implicitWidth + 5) 
      implicitHeight: 18

      readonly property int workspaceId: windowRoot.startWorkspace + index
      property bool isActive: Hyprland.focusedWorkspace?.id === workspaceId

      Text {
        id: workspaceText
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: isActive ? "#454545" : ("#b3b3b3")
        text: parent.workspaceId.toString()
        font { pixelSize: 14; bold: true}
      }
    }
  }
  Item { Layout.fillWidth: true }
}
