import QtQml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import "../lib" as Lib

import org.kde.plasma.private.brightnesscontrolplugin


Lib.Slider {
    id: brightnessControl

    // Plasma 6.4+ removed the aggregate ScreenBrightnessControl.brightness /
    // .brightnessMax scalars in favour of a per-display model. This single
    // slider drives the first available display as the representative one.
    readonly property var display: displays.count > 0 ? displays.objectAt(0) : null

    readonly property int brightnessMax: display ? display.maxBrightness : 100
    readonly property int brightnessMin: (brightnessMax > 100 ? 1 : 0)
    property int screenBrightness: display ? display.brightness : 0

    readonly property bool isBrightnessAvailable: sbControl.isBrightnessAvailable

    // Should be visible ONLY if the monitor supports it
    visible: isBrightnessAvailable && root.showBrightness

    // Dimensions
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2

    // Slider properties
    title: i18n("Display Brightness")
    source: "brightness-high"
    secondaryTitle: brightnessMax > 0 ? Math.round((screenBrightness / brightnessMax) * 100) + "%" : "—"

    from: brightnessMin
    to: brightnessMax
    value: screenBrightness

    onMoved: {
        if (!display) {
            return;
        }
        const v = Math.max(brightnessMin, Math.min(brightnessMax, value));
        screenBrightness = v;
        sbControl.setBrightness(display.displayName, v);
    }

    /// Components ///

    ScreenBrightnessControl {
        id: sbControl
        isSilent: true
    }

    // Exposes the roles of the ScreenBrightnessControl.displays model
    // (displayName / brightness / maxBrightness) as addressable objects.
    Instantiator {
        id: displays
        model: sbControl.displays
        delegate: QtObject {
            required property string displayName
            required property int brightness
            required property int maxBrightness
        }
    }
}
