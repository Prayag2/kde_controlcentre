import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "lib" as Lib


Lib.Slider {
    // visible: root.isBrightnessAvailable
    Layout.preferredWidth: parent.width
    // Layout.preferredHeight: wrapper.height/4
    Layout.preferredHeight: sectionA.height/2
    title: "Display Brightness"
    source: "brightness-high"
    secondaryTitle: Math.round((root.screenBrightness / root.maximumScreenBrightness)*100) + "%"
    spacerWidth: 150 * root.scale
    from: 0
    to: root.maximumScreenBrightness
    value: root.screenBrightness
    onMoved: {
        root.screenBrightness = value
    }
    
}
