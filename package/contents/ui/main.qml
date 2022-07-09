import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    // PROPERTIES
    property bool enableTransparency: false
    property var animationDuration: PlasmaCore.Units.veryShortDuration

    property var scale: 1.3 * PlasmaCore.Units.devicePixelRatio
    property int fullRepWidth: 300 * scale
    property int fullRepHeight: 300 * scale

    property int margin: 10 * scale
    property int cardMargin: 7 * scale
    property int gridMargin: 5 * scale

    property int buttonMargin: 4
    property int buttonIconMargin: 6 * scale
    property int buttonHeight: 40* scale
    property int buttonTitleFontSize: 12 * scale
    property int buttonSubtitleFontSize: 10 * scale
    property int smallCardButtonFontSize: 6 * scale

    Plasmoid.fullRepresentation: FullRepresentation {}
    //Plasmoid.compactRepresentation: CompactRepresentation {}
}
