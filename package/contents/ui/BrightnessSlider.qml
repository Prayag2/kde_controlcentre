import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "lib" as Lib


Lib.Slider {
    visible: root.isBrightnessAvailable
    Layout.preferredWidth: parent.width
    Layout.preferredHeight: wrapper.height/4
    title: "Display Brightness"
    source: "brightness-high"
    from: 0
    to: root.maximumScreenBrightness
    value: root.screenBrightness
    onMoved: {
        root.screenBrightness = value
    }
    
}
