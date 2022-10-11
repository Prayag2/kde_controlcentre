import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15

import org.kde.kdeconnect 1.0 as KdeConnect
import org.kde.plasma.core 2.0 as PlasmaCore

import "../lib" as Lib
import "../js/funcs.js" as Funcs

Lib.CardButton {
    visible: root.showKDEConnect
    Layout.fillWidth: true
    Layout.fillHeight: true
    title: i18n("KDE Connect")
    PlasmaCore.IconItem {
        anchors.fill: parent
        source: "kdeconnect-tray"
    }
    onClicked: KdeConnect.OpenConfig.openConfiguration();
}