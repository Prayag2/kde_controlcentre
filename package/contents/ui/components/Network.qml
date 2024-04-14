import QtQml
import QtQuick
import org.kde.plasma.networkmanagement as PlasmaNM

Item {
    property var appletProxyModel: appletProxyModel
    property var networkStatus: networkStatus.networkStatus
    property var activeConnectionIcon: activeConnectionIcon.connectionIcon
    property var enabledConnections: enabledConnections
    property var availableDevices: availableDevices
    property var handler: handler


    PlasmaNM.ConnectionIcon {
        id: activeConnectionIcon
    }
    PlasmaNM.Handler {
        id: handler
    }
    PlasmaNM.NetworkStatus {
        id: networkStatus
    }
    PlasmaNM.AppletProxyModel {
        id: appletProxyModel
        sourceModel: PlasmaNM.NetworkModel{}
    }
    PlasmaNM.EnabledConnections {
        id: enabledConnections
    }
    PlasmaNM.AvailableDevices {
        id: availableDevices
    }


}
