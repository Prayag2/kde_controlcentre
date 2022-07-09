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

    DeRect {
        border.color: "red"
    }

    PlasmaCore.FrameSvgItem {
        id: rect

        imagePath: root.enableTransparency ? "translucent/dialogs/background" : "opaque/dialogs/background"
        clip: true
        anchors.fill: parent
        anchors.topMargin: rect.margins.top
        anchors.leftMargin: rect.margins.left
        anchors.rightMargin: rect.margins.right
        anchors.bottomMargin: rect.margins.bottom

        Item {
            id: dataContainer
            anchors.fill: parent
        }
    }
}
