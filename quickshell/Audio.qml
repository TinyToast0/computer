import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

Item {
  id: audioWidget

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.nodes]
  }
  readonly property var defaultSink: Pipewire.defaultAudioSink
  readonly property var audioData: defaultSink ? defaultSink.audio : null
  Button {
    id: volumeButton
    implicitHeight: 25
    implicitWidth: 27
    Text {
      anchors {
        top: parent.top
        topMargin: 3
        horizontalCenter: parent.horizontalCenter
      }
      color: windowRoot.Theme.foreground
      font.pixelSize: 15
      text: "🕪"
    }
    onClicked: osdLayout.opacity = (osdLayout.opacity > 0) ? 0.0 : 1.0

    background: Rectangle {
      color: parent.palette.button
    }
    palette.button: Qt.lighter(windowRoot.Theme.background, 1.5)
    palette.buttonText: windowRoot.Theme.foreground

  }
  PopupWindow {
    id: osdPopup

    visible: osdLayout.opacity > 0

    anchor {
      item: volumeButton
      edges: Edges.Bottom
      margins.top: 31
      margins.left: -380
    }implicitHeight: 150
    implicitWidth: 200
    color: "transparent"

    Rectangle {
      id: osdLayout
      anchors.fill: parent
      color: windowRoot.Theme.background
      border.color: windowRoot.Theme.accent1
      border.width: 2
      opacity: 0.0

    Column {
      id: selector
      anchors {
        top: parent.top
        topMargin: 5
        left: parent.left
        leftMargin: 5
        right: parent.right
        rightMargin: 5
      }
      spacing: 4

      Repeater {
        model: Pipewire.nodes.values.filter(node => {
          const isSink = (node.type & PwNodeType.Audio) && (node.type & PwNodeType.Sink);
          const desc = node.description || "";

          const matchesTarget = desc.includes("Astro A50 Chat") || desc.includes("Built-in Audio Analog Stereo");

          return isSink && matchesTarget;
        })

        delegate: Rectangle {
          width: selector.width
          height: 22
          radius: 0

          color: (audioWidget.defaultSink === modelData) ? windowRoot.Theme.accent1 : Qt.darker(windowRoot.Theme.background, 1.2)

          Text {
            anchors.centerIn: parent
            font.pointSize: 8
            text: modelData.description || modelData.name || "Unknown Output"
            color: (audioWidget.defaultSink === modelData) ? windowRoot.Theme.background : windowRoot.Theme.foreground
          }

          MouseArea {
            anchors.fill: parent
            onClicked: {
              Pipewire.preferredDefaultAudioSink = modelData
            }
          }
        }
      }
    }


      Text {
        anchors {
          bottom: parent.bottom
          bottomMargin: 25
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
          bottom: parent.bottom
          bottomMargin: 25
          left: parent.left
          leftMargin: 115
        }
        color: windowRoot.Theme.foreground
        font.pointSize: 9
        font.bold: true
        text: audioWidget.audioData ? Math.round(audioWidget.audioData.volume * 100) + "%" : "0%"
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

        readonly property real volumeValue: audioWidget.audioData ? audioWidget.audioData.volume : 0.0

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
        MouseArea {
          id: sliderMouseArea
          anchors.fill: parent
          preventStealing: true

          function updateVolume(mouseEvent) {
            if (audioWidget.audioData) {
              let newValue = Math.max(0.0, Math.min(1.0, mouseEvent.x / width));
              audioWidget.audioData.volume = newValue;
            }
          }
          onPressed: (mouse) => updateVolume(mouse)
          onPositionChanged: (mouse) => updateVolume(mouse)
        }
      }
    }
  }
}

