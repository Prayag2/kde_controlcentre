import QtQuick 2.0
import QtQml 2.0
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
    color: "transparent"
    property alias prefix: rect.prefix
    property var margins: rect.margins
    default property alias content: dataContainer.data


    PlasmaCore.FrameSvgItem {
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
