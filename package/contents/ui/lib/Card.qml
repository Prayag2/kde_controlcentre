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
        anchors.topMargin: rect.margins.top * root.scale
        anchors.leftMargin: rect.margins.left * root.scale
        anchors.rightMargin: rect.margins.right * root.scale
        anchors.bottomMargin: rect.margins.bottom * root.scale

        Item {
            id: dataContainer
            anchors.fill: parent
        }
    }
}
