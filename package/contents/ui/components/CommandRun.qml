import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15

import org.kde.plasma.core 2.0 as PlasmaCore

import "../lib" as Lib
import "../js/funcs.js" as Funcs

Lib.CardButton {
    property string icon;
    property string command;
    property bool isSmall;
    
    Layout.fillWidth: true
    Layout.fillHeight: !isSmall

    Layout.preferredHeight: isSmall ? root.sectionHeight / 2 : undefined

    function exec(cmd) {
        executable.connectSource(cmd)
    }
    
    PlasmaCore.IconItem {
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