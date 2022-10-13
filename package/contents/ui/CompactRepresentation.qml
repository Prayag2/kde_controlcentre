import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: compactRep
    
    RowLayout {
        anchors.fill: parent
        
        PlasmaCore.IconItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: root.mainIconName
            smooth: true
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    plasmoid.expanded = !plasmoid.expanded
                }
            }
        }
    }
}