import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "lib" as Lib

Lib.Card {
    id: mediaPlayer
    Layout.preferredWidth: parent.width
    Layout.preferredHeight: sectionA.height/2

    RowLayout {
        anchors.fill: parent
        anchors.margins: root.margin

        Image {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            source: 'https://upload.wikimedia.org/wikipedia/en/b/b9/The_Weeknd_-_Dawn_FM.png'
        }
        ColumnLayout {
            id: mediaNameWrapper
            Layout.margins: root.gridMargin
            Layout.fillHeight: true
            spacing: 0

            PlasmaComponents.Label {
                text: "Is there someone else?"
                Layout.fillWidth: true
                font.capitalization: Font.Capitalize
                font.weight: Font.Bold
                font.pixelSize: root.buttonTitleFontSize
                elide: Text.ElideRight
            }
            PlasmaComponents.Label {
                text: "The Weeknd"
                Layout.fillWidth: true
                font.pixelSize: root.buttonSubtitleFontSize
            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight

            PlasmaCore.IconItem {
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-playback-start"
            }
            PlasmaCore.IconItem {
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-skip-forward"
            }
        }
    }
}
