pragma Singleton

import QtQuick

QtObject {
  property var colors: ({})
  property var special: ({})
  property color bg_transparent

  function setColors(obj) {
    colors = obj.colors || ({});
    special = obj.special || ({});
  }

}
