// Qt/Qml
import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

// Plasma
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
    id: button
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.maximumHeight: 48
    radius: plasmoid.configuration.border_radius
    color: "transparent"
    property color cardColor: root.cardColor
    property alias source: icon.source
    property alias title: title.text
    property alias subtitle: subtitle.text

    signal clicked

    RowLayout {
        anchors.fill: parent
        anchors.margins: PlasmaCore.Units.smallSpacing * root.sizeFactor


        Rectangle {
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: height
            radius: height/2*root.sizeFactor
            color: PlasmaCore.Theme.buttonFocusColor

            PlasmaCore.IconItem {
                id: icon
                anchors.fill: parent
                anchors.centerIn: parent
                anchors.margins: PlasmaCore.Units.mediumSpacing * root.sizeFactor
            }
        }
        ColorOverlay {
            anchors.fill: icon
            source: icon
            color: PlasmaCore.Theme.buttonTextColor
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            PlasmaComponents.Label {
                id: title
                Layout.fillWidth: true
                elide: Text.ElideRight
                font.pixelSize: 14*root.sizeFactor
                font.weight: Font.Bold
            }
            PlasmaComponents.Label {
                id: subtitle
                Layout.fillWidth: true
                font.pixelSize: 12*root.sizeFactor
                elide: Text.ElideRight
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            button.color = Qt.rgba(cardColor.r, cardColor.g, cardColor.b, 0.2)
        }
        onExited: {
            button.color = "transparent"
        }
        onPressed: {
            button.color = Qt.rgba(cardColor.r, cardColor.g, cardColor.b, 0.4)
        }
        onClicked: {
            parent.clicked()
        }
    }
}
