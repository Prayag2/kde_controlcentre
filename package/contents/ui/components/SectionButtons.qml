import QtQml
import QtQuick
import QtQuick.Layouts

import org.kde.plasma.core as PlasmaCore
import org.kde.bluezqt as BluezQt
import org.kde.kcmutils

import "../lib" as Lib
import "../js/funcs.js" as Funcs

Lib.Card {
    id: sectionButtons
    Layout.fillWidth: true
    Layout.fillHeight: true

    // NETWORK
    property var network: network
    Network {
        id: network
    }

    // BLUETOOTH
    property QtObject btManager : BluezQt.Manager

    // All Buttons
    ColumnLayout {
        id: buttonsColumn
        anchors.fill: parent
        anchors.bottomMargin: root.smallSpacing
        anchors.topMargin: root.smallSpacing
        spacing: 0

        Lib.LongButton {
            title: i18n("Network")
            subtitle: network.networkStatus
            source: network.activeConnectionIcon
            sourceColor: network.networkStatus === "Connected" ?
Kirigami.Theme.highlightColor : Kirigami.Theme.disabledTextColor
            onClicked: {
                sectionNetworks.toggleNetworkSection()
            }
        }

        Lib.LongButton {
            title: i18n("Bluetooth")
            subtitle: Funcs.getBtDevice()
            source: "network-bluetooth"
            onClicked: {
                Funcs.toggleBluetooth()
            }
        }

        Lib.LongButton {
            title: i18n("Settings")
            subtitle: i18n("System Settings")
            source: "settings-configure"
            onClicked: {
                KCMLauncher.openSystemSettings("")
            }
        }
    }
}
