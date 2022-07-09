// Qt/QML
import QtQuick 2.0
import QtQml 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

// Plasma
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import org.kde.bluezqt 1.0 as BluezQt

Item {
    id: fullRep

    // LAYOUT
    Layout.preferredWidth: 400 * root.sizeFactor * PlasmaCore.Units.devicePixelRatio
    Layout.preferredHeight: 400 * root.sizeFactor * PlasmaCore.Units.devicePixelRatio

    PlasmaNM.NetworkStatus {
        id: networkStatus
    }
    PlasmaNM.ConnectionIcon {
        id: connectionIcon
    }
    PlasmaNM.AvailableDevices {
        id: availableDevices
    }
    PlasmaNM.AppletProxyModel {
        id: networkModel
        property PlasmaNM.NetworkModel connectionModel: null;
        sourceModel: connectionModel
    }
    Component.onCompleted: {
        console.log("************************")
        console.log(JSON.stringify(availableDevices))
        console.log("************************")
    }

    // PROPERTIES
    // Get name of the first active connection
    property string activeConnection: networkStatus.activeConnections.split('\n')[0]

    // COLUMN
    GridLayout {
        anchors.fill: parent
        anchors.margins: plasmoid.configuration.spacing/2

        columns: 4
        rowSpacing: plasmoid.configuration.spacing
        columnSpacing: rowSpacing

        Card {
            Layout.columnSpan: 2
            Layout.rowSpan: 2
            Layout.fillWidth: false
            Layout.preferredWidth: parent.width/2

            ColumnLayout {
                id: buttons
                anchors.fill: parent
                anchors.margins: plasmoid.configuration.spacing/2
                spacing: 0

                SmallButton {
                    source: connectionIcon.connectionTooltipIcon
                    title: activeConnection.split(" ")[0].slice(0,-1)
                    subtitle: activeConnection.split(":")[1].slice(14)

                    onClicked: {
                    }
                }
                SmallButton {
                    visible: !root.btDisabled
                    source: "network-bluetooth"
                    title: "Bluetooth"
                    subtitle: root.btConnected ? "Connected" : "Not Connected"
                }
                SmallButton {
                    source: "klipper"
                }
            }
        }
        Card {
            Layout.columnSpan: 2
        }
        Card {}
        Card {}

        Card {
            Layout.columnSpan: 4
        }
        Card {
            Layout.columnSpan: 4
        }
    }
}
