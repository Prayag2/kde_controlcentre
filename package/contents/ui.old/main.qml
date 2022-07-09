// Qt/QML
import QtQuick 2.0
import QtQml 2.0
import QtQuick.Layouts 1.15

// Plasma
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.bluezqt 1.0 as BluezQt
import "logic.js" as Logic

Item {
    id: root

    // PROPERTIES
    property color cardColor: Qt.lighter(PlasmaCore.Theme.backgroundColor, 10)

    // FONT SIZES
    property var sizeFactor: 1 * PlasmaCore.Units.devicePixelRatio

    // Bluetooth
    property QtObject btManager: BluezQt.Manager
    property bool btDisabled: (
        btManager.rfkill.state === BluezQt.Rfkill.Unknown ||
        btManager.bluetoothBlocked ||
        !btManager.bluetoothOperational
    )
    property bool btConnected: Logic.updateStatus()

    // COMPACT REPRESENTATION
    // FULL REPRESENTATION

    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    Plasmoid.fullRepresentation: FullRepresentation {}
    Component.onCompleted: {
        console.log("HELLLOOOOOOO")
        console.log("HELLLOOOOOOO")
    }
}
