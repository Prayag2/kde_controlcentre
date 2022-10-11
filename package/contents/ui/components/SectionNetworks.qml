import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../lib" as Lib

Lib.Card {
    id: sectionNetworks
    anchors.fill: parent
    z: 999
    visible: false      
    
    // NETWORK
    property var network: network
    Network {
        id: network
    }
    
    function toggleNetworkSection() {
        if(!sectionNetworks.visible) {
            wrapper.visible = false
            sectionNetworks.visible = true
        } else {
            wrapper.visible = true
            sectionNetworks.visible = false
        }
    }
    
    Item {
        anchors.fill: parent
        anchors.margins: root.smallSpacing
        clip: true
        
        ListView {
            anchors.fill: parent
            ScrollBar.vertical: ScrollBar {}
            model: network.appletProxyModel
            
            delegate: ConnectionItem {
                width: parent.width
                height: root.buttonHeight
            }
            
            header: ColumnLayout {
                width: parent.width
                spacing: root.smallSpacing
                RowLayout{
                    height: implicitHeight + root.smallSpacing
                    PlasmaComponents.ToolButton {
                        Layout.preferredHeight: root.largeFontSize*2.5
                        iconSource: "arrow-left"
                        
                        onClicked: {
                            sectionNetworks.toggleNetworkSection()
                        }
                    }
                    PlasmaComponents.Label {
                        text: i18n("Network Connections")
                        font.pixelSize: root.largeFontSize * 1.2
                        Layout.fillWidth: true
                    }
                }
                PlasmaCore.SvgItem {
                    id: separatorLine
                    elementId: "horizontal-line"
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.scale
                    svg: PlasmaCore.Svg {
                        imagePath: "widgets/line"
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }
}