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
