import QtQml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasma5support as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import "../lib" as Lib

import org.kde.plasma.private.brightnesscontrolplugin


Lib.Slider {
    id: brightnessControl

    readonly property int brightnessMax: sbControl.brightnessMax
    readonly property int brightnessMin: (brightnessMax > 100 ? 1 : 0)

    property int screenBrightness: sbControl.brightness
    property bool disableBrightnessUpdate: true

    // Should be visible ONLY if the monitor supports it
    visible: isBrightnessAvailable && root.showBrightness

    // Dimensions
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2

    // Slider properties
    title: "Display Brightness"
    source: "brightness-high"
    secondaryTitle: Math.round((screenBrightness / brightnessMax)*100) + "%"

    from: brightnessMin
    to: brightnessMax
    value: sbControl.brightness

    readonly property bool isBrightnessAvailable: sbControl.isBrightnessAvailable

    onMoved: {
        screenBrightness = value

        sbControl.brightness = Math.max(brightnessMin, Math.min(brightnessMax, value));
    }

    /// Components ///

    ScreenBrightnessControl {
        id: sbControl
        isSilent: true
    }
}
