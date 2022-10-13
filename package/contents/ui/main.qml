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
    property bool showCmd1: plasmoid.configuration.showCmd1
    property bool showCmd2: plasmoid.configuration.showCmd2
    
    property string cmdRun1: plasmoid.configuration.cmdRun1
    property string cmdTitle1: plasmoid.configuration.cmdTitle1
    property string cmdIcon1: plasmoid.configuration.cmdIcon1
    property string cmdRun2: plasmoid.configuration.cmdRun2
    property string cmdTitle2: plasmoid.configuration.cmdTitle2
    property string cmdIcon2: plasmoid.configuration.cmdIcon2

    Plasmoid.fullRepresentation: FullRepresentation {}
    //Plasmoid.compactRepresentation: CompactRepresentation {}
}
