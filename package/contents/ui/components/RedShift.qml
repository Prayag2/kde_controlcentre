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
        source: monitor.running ? "redshift-status-on" : "redshift-status-off"
    }
    onClicked: {
        Funcs.toggleNightLight();
    }

    // Components //

    NightColorInhibitor {
        id: inhibitor
    }

    NightColorMonitor {
        id: redMonitor

        readonly property bool transitioning: monitor.currentTemperature != monitor.targetTemperature
        readonly property bool hasSwitchingTimes: monitor.mode != 3
    }
}
