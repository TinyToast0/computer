import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Services.Mpris

Row {
  spacing: 5          
  readonly property list<MprisPlayer> allPlayers: Mpris.players.values
            
  readonly property MprisPlayer spotifyPlayer: {
    for (var i = 0; i < allPlayers.length; i++) {
      if (allPlayers[i].dbusName.includes("spotify")) {
        return allPlayers[i];
      }
    }
    return null;
  }

  // previous button
  Button {
    implicitWidth: 30
    text: "<<"
    flat: true

    background: Rectangle {
      color: parent.palette.button
    }

    palette.button: Qt.lighter(windowRoot.Theme.background, 1.3)
    palette.buttonText: windowRoot.Theme.foreground
    onClicked: {
      if (spotifyPlayer) {
        spotifyPlayer.previous();
      }
    }
  }
  // playing button
  Button {
    implicitWidth: 200
    text: spotifyPlayer ? (spotifyPlayer.trackTitle + " - " + spotifyPlayer.trackArtist) : "No music Playing"
    flat: true
    highlighted: true

    background: Rectangle {
      color: parent.palette.button
    }

    palette.button: Qt.lighter(windowRoot.Theme.background, 1.3)
    palette.buttonText: windowRoot.Theme.foreground

    onClicked: {
      if (spotifyPlayer) {
        spotifyPlayer.togglePlaying();
      }
    }
  }
  
  // next button
  Button {
    implicitWidth: 30
    text: ">>"
    flat: true

    background: Rectangle {
      color: parent.palette.button
    }

    palette.button: Qt.lighter(windowRoot.Theme.background, 1.3)
    palette.buttonText: windowRoot.Theme.foreground
    onClicked: {
      if (spotifyPlayer) {
        spotifyPlayer.next();
      }
    }
  }
}
