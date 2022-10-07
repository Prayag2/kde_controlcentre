import QtQuick 2.0
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root
    
    property string currentPage: "fullRep"
    clip: true

    // PROPERTIES
    property bool enableTransparency: plasmoid.configuration.transparency
    property var animationDuration: PlasmaCore.Units.veryShortDuration

    property var scale: plasmoid.configuration.scale * PlasmaCore.Units.devicePixelRatio / 100
    property int fullRepWidth: 300 * scale
    property int fullRepHeight: 300 * scale

    property int largeSpacing: 10 * scale
    property int mediumSpacing: 7 * scale
    property int smallSpacing: 5 * scale

    property int buttonMargin: 4 * scale
    property int buttonHeight: 40 * scale

    property int largeFontSize: 12 * scale
    property int mediumFontSize: 10 * scale
    property int smallFontSize: 6 * scale

    Plasmoid.fullRepresentation: FullRepresentation {}
    //Plasmoid.compactRepresentation: CompactRepresentation {}
}
