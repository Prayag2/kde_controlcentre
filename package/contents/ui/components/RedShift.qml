import QtQml
import QtQuick
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.brightnesscontrolplugin

import "../lib" as Lib
import "../js/funcs.js" as Funcs


Lib.CardButton {
    // NIGHT COLOUR CONTROL
    visible: root.showNightColor
    property var monitor: redMonitor
    property var inhibitor: inhibitor

    Layout.fillWidth: true
    Layout.fillHeight: true
    title: i18n("Night Color")

    Kirigami.Icon {
        anchors.fill: parent
        source: control.running ? "redshift-status-on" : "redshift-status-off"
    }
    onClicked: control.toggleInhibition()

    // Components //

    /// Plasma 6.1 ///
    NightLightControl {
        id: control

        readonly property bool transitioning: control.currentTemperature != control.targetTemperature
        readonly property bool hasSwitchingTimes: control.mode != 3
        readonly property bool togglable: !control.inhibited || control.inhibitedFromApplet
    }
}
