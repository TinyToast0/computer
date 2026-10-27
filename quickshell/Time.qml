pragma Singleton

import Quickshell // for PanelWindow
import QtQuick // for Text

Singleton {
  id: root

  // add a property in the root
  readonly property string time: {
    Qt.formatDateTime(clock.date, "h:mm d MMM")
  }
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
