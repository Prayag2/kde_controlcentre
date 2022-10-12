import QtQuick 2.0
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.1 as PlasmaCore


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
    property int sectionHeight: 150 * scale

    property int largeSpacing: 10 * scale
    property int mediumSpacing: 7 * scale
    property int smallSpacing: 5 * scale

    property int buttonMargin: 4 * scale
    property int buttonHeight: 40 * scale

    property int largeFontSize: 12 * scale
    property int mediumFontSize: 10 * scale
    property int smallFontSize: 6 * scale
    
    // Components
    property bool showKDEConnect: plasmoid.configuration.showKDEConnect
    property bool showNightColor: plasmoid.configuration.showNightColor
    property bool showColorSwitcher: plasmoid.configuration.showColorSwitcher
    property bool showDnd: plasmoid.configuration.showDnd
    property bool showVolume: plasmoid.configuration.showVolume
    property bool showBrightness: plasmoid.configuration.showBrightness
    property bool showMediaPlayer: plasmoid.configuration.showMediaPlayer

    Plasmoid.fullRepresentation: FullRepresentation {}
    //Plasmoid.compactRepresentation: CompactRepresentation {}
}
