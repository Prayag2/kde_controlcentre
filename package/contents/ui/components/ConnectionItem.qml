import QtQuick 2.0
import "../lib" as Lib
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM


Lib.LongButton {
    title: Name
    source: ConnectionIcon
    
    Network {
        id: network
    }
    
    function itemText() {
        if (ConnectionState == PlasmaNM.Enums.Activating) {
            if (Type == PlasmaNM.Enums.Vpn)
                return VpnState
            else
                return DeviceState
        } else if (ConnectionState == PlasmaNM.Enums.Deactivating) {
            if (Type == PlasmaNM.Enums.Vpn)
                return VpnState
            else
                return DeviceState
        } else if (Uuid && ConnectionState == PlasmaNM.Enums.Deactivated) {
            return LastUsed
        } else if (ConnectionState == PlasmaNM.Enums.Activated) {
            return i18n("Connected")
        }
        return "Unknown"
    }
    subtitle: itemText()
    
    onClicked: {
        if (ConnectionState == PlasmaNM.Enums.Activated) {
            network.handler.deactivateConnection(ConnectionPath, DevicePath)
        } else {
            network.handler.activateConnection(ConnectionPath, DevicePath, SpecificPath)
        }
    }
}