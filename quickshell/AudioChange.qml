import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

Item {
  id: mainAudio

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }
  readonly property var defaultSink: Pipewire.defaultAudioSink
  readonly property var audioData: defaultSink ? defaultSink.audio : null

  PopupWindow {
    id: osdPopup

    visible: mainAudioLayout.opacity > 0

    anchor {
      item: mainAudio
      edges: Edges.Bottom
      margins.top: 31
      margins.left: -30
    }implicitHeight: 50
    implicitWidth: 200
    color: "transparent"

    Rectangle {
      id: mainAudioLayout
      anchors.fill: parent
      color: windowRoot.Theme.background
      border.color: windowRoot.Theme.accent1
      border.width: 2
      opacity: 0.0

      NumberAnimation on opacity {
        id: fadeOutAnimation
        to: 0
        duration: 300
        running: false
      }
      Connections {
        target: mainAudio.audioData
        ignoreUnknownSignals: true

        function onVolumeChanged() {
          mainAudioLayout.opacity = 1.0;
          osdTimer.restart();
        }
      }
      Timer {
        id: osdTimer
        interval: 1500
        repeat: false
        onTriggered: fadeOutAnimation.start()
      }

      Text {
        anchors {
          top: parent.top
          topMargin: 5
          left: parent.left
          leftMargin: 60
        }
        color: windowRoot.Theme.foreground
        font.pointSize: 9
        font.bold: true
        text: "Volume:"
      }
      Text {
        anchors {
          top: parent.top
          topMargin: 5
          left: parent.left
          leftMargin: 115
        }
        color: windowRoot.Theme.foreground
        font.pointSize: 9
        font.bold: true
        text: mainAudio.audioData ? Math.round(mainAudio.audioData.volume * 100) + "%" : "0%"
      }

      Item {
        id: customSlider
        anchors {
          left: parent.left
          leftMargin: 10
          right: parent.right
          rightMargin: 10
          bottom: parent.bottom
          bottomMargin: 5
        }
        height: 16

        readonly property real volumeValue: mainAudio.audioData ? mainAudio.audioData.volume : 0.0

        Rectangle {
          id: track

          anchors.fill: parent
          radius: 0
          color: Qt.darker(windowRoot.Theme.background, 1.4)
          border.color: Qt.darker(windowRoot.Theme.background, 1.1)
          border.width: 1
          clip: true

          Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: customSlider.volumeValue * parent.width
            color: windowRoot.Theme.accent1
            radius: 0
          }
        }
      }
    }
  }
}

