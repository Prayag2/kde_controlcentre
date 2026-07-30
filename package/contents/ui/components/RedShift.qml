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

    Layout.fillWidth: true
    Layout.fillHeight: true
    title: i18n("Night Color")

    Kirigami.Icon {
        anchors.fill: parent
        // inhibited == Night Light is paused, so "on" is the un-inhibited state.
        source: NightLightInhibitor.inhibited ? "redshift-status-off" : "redshift-status-on"
    }
    // Plasma 6.4+ replaced the instantiable NightLightControl with the
    // NightLightInhibitor singleton (inhibited bool + toggleInhibition()).
    onClicked: NightLightInhibitor.toggleInhibition()
}
