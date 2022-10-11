import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaCore.FrameSvgItem {
    id: button

    imagePath: "widgets/viewitem"
    prefix: mouseArea.containsMouse ? (mouseArea.pressed ? "selected+hover" : "hover") : "normal"
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.rightMargin: root.smallSpacing
    Layout.leftMargin: root.smallSpacing
    signal clicked;

    property alias title: title.text
    property alias subtitle: subtitle.text
    property alias source: icon.source

    property int margin: root.buttonMargin

    GridLayout {
        rows: 2; columns: 2
        anchors.fill: parent
        anchors.margins: button.margin
        rowSpacing: -root.mediumSpacing
        columnSpacing: root.mediumSpacing
        clip: true

        Icon {
            id: icon
            Layout.rowSpan: 2
            Layout.preferredHeight: parent.height - root.smallSpacing //
            Layout.preferredWidth: Layout.preferredHeight
        }

        PlasmaComponents.Label {
            id: title
            Layout.fillWidth: true
            font.pixelSize: root.largeFontSize
            font.weight: Font.Bold
            elide: Text.ElideRight
        }
        PlasmaComponents.Label {
            id: subtitle
            Layout.fillWidth: true
            font.pixelSize: root.mediumFontSize
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            button.clicked()
        }
    }
}
