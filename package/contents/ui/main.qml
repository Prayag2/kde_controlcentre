import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root

    clip: true

    // PROPERTIES
    property bool enableTransparency: plasmoid.configuration.transparency
    property var animationDuration: Kirigami.Units.veryShortDuration
    property bool playVolumeFeedback: plasmoid.configuration.playVolumeFeedback

    property var scale: plasmoid.configuration.scale * 0.01
    property int fullRepWidth: 360 * scale
    property int fullRepHeight: 360 * scale
    property int sectionHeight: 180 * scale

    property int largeSpacing: 12 * scale
    property int mediumSpacing: 8 * scale
    property int smallSpacing: 6 * scale

    property int buttonMargin: 4 * scale
    property int buttonHeight: 48 * scale

    property int largeFontSize: 15 * scale
    property int mediumFontSize: 12 * scale
    property int smallFontSize: 7 * scale

    // Main Icon
    property string mainIconName: plasmoid.configuration.mainIconName
    property string mainIconHeight: plasmoid.configuration.mainIconHeight

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
    property bool showPercentage: plasmoid.configuration.showPercentage

    property string cmdRun1: plasmoid.configuration.cmdRun1
    property string cmdTitle1: plasmoid.configuration.cmdTitle1
    property string cmdIcon1: plasmoid.configuration.cmdIcon1
    property string cmdRun2: plasmoid.configuration.cmdRun2
    property string cmdTitle2: plasmoid.configuration.cmdTitle2
    property string cmdIcon2: plasmoid.configuration.cmdIcon2

    readonly property bool inPanel: (Plasmoid.location === PlasmaCore.Types.TopEdge
        || Plasmoid.location === PlasmaCore.Types.RightEdge
        || Plasmoid.location === PlasmaCore.Types.BottomEdge
        || Plasmoid.location === PlasmaCore.Types.LeftEdge)

    switchHeight: fullRepWidth
    switchWidth: fullRepWidth
    preferredRepresentation: inPanel ? plasmoid.compactRepresentation : plasmoid.fullRepresentation
    fullRepresentation: FullRepresentation {}
    compactRepresentation: CompactRepresentation {}
}
