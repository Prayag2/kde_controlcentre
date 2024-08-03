import QtQuick
import QtQml
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import org.kde.ksvg as KSvg
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents

Rectangle {
    color: "transparent"
    property alias prefix: rect.prefix
    property var margins: rect.margins
    default property alias content: dataContainer.data


    KSvg.FrameSvgItem {
        id: rect

        imagePath: root.enableTransparency ? "translucent/dialogs/background" : "opaque/dialogs/background"
        clip: true
        anchors.fill: parent
        anchors.topMargin: -rect.inset.top + PlasmaCore.Units.smallSpacing * 1.5
        anchors.leftMargin: -rect.inset.left  + PlasmaCore.Units.smallSpacing * 1.5
        anchors.rightMargin: -rect.inset.right  + PlasmaCore.Units.smallSpacing * 1.5
        anchors.bottomMargin: -rect.inset.bottom  + PlasmaCore.Units.smallSpacing * 1.5

        Item {
            id: dataContainer
            anchors.fill: parent
            anchors.topMargin: rect.margins.top-rect.inset.top
            anchors.leftMargin: rect.margins.left -rect.inset.left
            anchors.rightMargin: rect.margins.right -rect.inset.right
            anchors.bottomMargin: rect.margins.bottom -rect.inset.bottom
        }
    }
}
