import QtQml
import QtQuick
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support as PlasmaCore

import "../lib" as Lib
import "../js/funcs.js" as Funcs

Lib.CardButton {
    Layout.fillWidth: true
    Layout.fillHeight: true
    property string icon;
    property string command;

    function exec(cmd) {
        executable.connectSource(cmd)
    }

    Kirigami.Icon {
        anchors.fill: parent
        source: icon
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []

        onNewData: {
            disconnectSource(connectedSources)
        }
    }

    onClicked: {
        exec(command)
    }
}
